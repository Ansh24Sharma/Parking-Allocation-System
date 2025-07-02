package com.yash.parkingallocation.service;

import com.itextpdf.kernel.colors.ColorConstants;
import com.itextpdf.kernel.geom.PageSize;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.property.TextAlignment;

import com.itextpdf.io.source.ByteArrayOutputStream;
import com.itextpdf.layout.property.UnitValue;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Utils;
import com.yash.parkingallocation.dao.PaymentDAO;
import com.yash.parkingallocation.domain.Payment;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class PaymentServiceImpl implements PaymentService {

    // Test razorpay key and secret Id
    private final String keyId = "rzp_test_BZSOgBnXQoiSLs"; // Replace with your actual key
    private final String keySecret = "7w4e5De2WRns6f886ErSLi2b"; // Replace with your actual secret

    @Autowired
    private PaymentDAO paymentDao;

    @Autowired
    private ParkingService parkingService;

    private RazorpayClient getRazorpayClient() throws RazorpayException {
        return new RazorpayClient(keyId, keySecret);
    }

    @Override
    public String createOrder(int amount, String currency, String receipt, int slotId) {
        try {
            RazorpayClient razorpay = getRazorpayClient();
            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", amount * 100); // Amount in paisa
            orderRequest.put("currency", currency);
            orderRequest.put("receipt", receipt);
            Order order = razorpay.Orders.create(orderRequest);

            Payment payment = new Payment();
            payment.setOrderId(order.get("id").toString());
            payment.setAmount(amount);
            payment.setCurrency(currency);
            payment.setReceipt(receipt);
            payment.setCreatedAt(LocalDateTime.now());
            payment.setSlotId(slotId);
            paymentDao.save(payment);

            return order.get("id").toString(); // Return the order ID as a string
        } catch (RazorpayException e) {
            throw new RuntimeException("Error creating Razorpay order: " + e.getMessage(), e);
        } catch (Exception e) {
            throw new RuntimeException("Unexpected error occurred while creating Razorpay order", e);
        }
    }

    @Override
    public boolean verifySignature(String orderId, String paymentId, String signature) {
        try {
            // Generate the expected signature using the secret key
            String data = orderId + "|" + paymentId;

            // Verify the signature
            return Utils.verifySignature(data, signature, keySecret);
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Return false if verification fails
        }
    }

    @Override
    public Payment findByOrderId(String orderId) {
        return paymentDao.findByOrderId(orderId);
    }

    @Override
    public Payment findBySlotId(int slotId) {
        return paymentDao.findBySlotId(slotId);
    }

    public byte[] generateReceiptPdf(Payment payment) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdfDoc = new PdfDocument(writer);
        Document document = new Document(pdfDoc, PageSize.A4);
        document.setMargins(20, 20, 20, 20);

        // Add header
        Paragraph header = new Paragraph("Payment Receipt")
                .setTextAlignment(TextAlignment.CENTER)
                .setFontSize(18)
                .setBold()
                .setMarginBottom(20);
        document.add(header);

        // Add payment details table
        float[] columnWidths = {1, 3};
        Table table = new Table(columnWidths);
        table.setWidth(UnitValue.createPercentValue(100));
        // Add table header row
        table.addHeaderCell(new Cell().add(new Paragraph("Field").setBold()).setBackgroundColor(ColorConstants.LIGHT_GRAY));
        table.addHeaderCell(new Cell().add(new Paragraph("Details").setBold()).setBackgroundColor(ColorConstants.LIGHT_GRAY));

        // Add table rows
        table.addCell(new Cell().add(new Paragraph("Order ID")));
        table.addCell(new Cell().add(new Paragraph(payment.getOrderId())));
        table.addCell(new Cell().add(new Paragraph("Amount")));
        table.addCell(new Cell().add(new Paragraph(String.valueOf(payment.getAmount()))));
        table.addCell(new Cell().add(new Paragraph("Currency")));
        table.addCell(new Cell().add(new Paragraph(payment.getCurrency())));
        table.addCell(new Cell().add(new Paragraph("Receipt")));
        table.addCell(new Cell().add(new Paragraph(payment.getReceipt())));
        table.addCell(new Cell().add(new Paragraph("Slot ID")));
        table.addCell(new Cell().add(new Paragraph(String.valueOf(payment.getSlotId()))));
        table.addCell(new Cell().add(new Paragraph("Created At")));
        table.addCell(new Cell().add(new Paragraph(payment.getCreatedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))));

        document.add(table);

        // Add footer
        Paragraph footer = new Paragraph("Thank you for your payment!")
                .setTextAlignment(TextAlignment.CENTER)
                .setMarginTop(20);
        document.add(footer);

        document.close();
        return baos.toByteArray();
    }

    @Override
    public double getTotalRevenue() {
        return paymentDao.totalRevenue();
    }
}



import java.io.*;
import java.util.*;

import javax.print.*;
import javax.print.attribute.*;
import javax.print.attribute.standard.*;

public class Application {
    public static void main(String[] args) throws Exception {
        try {
            m_print();
        } catch (Exception ex) {
            System.out.println();
            throw ex; // re-throw
        }
    }

    private static void m_print() throws Exception {
        // we want to see incoming printing details
        System.setProperty("sun.print.ippdebug", "true");

        // let's show the world what we are actually testing
        System.out.println("Testing Printer Collection...");

        // prepare our required attributes and printer
        HashPrintRequestAttributeSet printRequestAttributes = new HashPrintRequestAttributeSet();
        PrintService printService = Objects.requireNonNull(PrintServiceLookup.lookupDefaultPrintService());

        // show some details about the incoming printer instance
        System.out.println("Printer Name: " + printService.getName());

        printRequestAttributes.add(new Copies(2));
        printRequestAttributes.add(OrientationRequested.PORTRAIT);

        // check if collation is supported on this printer
        if (printService.isAttributeCategorySupported(SheetCollate.class)) {
            System.out.println("Collation Supported!");
            printRequestAttributes.add(SheetCollate.COLLATED);
        } else {
            throw new RuntimeException("Collation Not Supported!");
        }

        // prepare the document to be set to the mock-printer
        String filename = "document.ps";
        DocFlavor flavor = DocFlavor.INPUT_STREAM.AUTOSENSE;
        Doc document = new SimpleDoc(new FileInputStream(filename), flavor, null);

        // finally attempt running our desired print job
        DocPrintJob printJob = printService.createPrintJob();
        System.out.println("Print Attempt: " + filename);
        printJob.print(document, printRequestAttributes);
    }
}

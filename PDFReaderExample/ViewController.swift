//
//  ViewController.swift
//  PDFReaderExample
//
//  Created by John Codeos on 5/2/23.
//

import PDFKit
import UIKit
import UniformTypeIdentifiers

class ViewController: UIViewController, UIDocumentPickerDelegate {
    
    @IBOutlet weak var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fix navigation bar color in iOS 15 and above
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(named: "primaryColor")
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        
        // displayPDF()
    }
    
//    func displayPDF() {
//        guard let path = Bundle.main.path(forResource: "fw9", ofType: "pdf") else { return }
//        let url = URL(fileURLWithPath: path)
//        guard let pdfDocument = PDFDocument(url: url) else { return }
//
//        pdfView.document = pdfDocument
//        // Enable automatic scaling of the PDF view to fit the content within the available space
//        pdfView.autoScales = true
//    }
    
    @IBAction func openDocumentPickerAction(_ sender: UIBarButtonItem) {
        showDocumentPicker()
    }
    
    private func showDocumentPicker() {
        let documentPicker: UIDocumentPickerViewController
        let pdfType = "com.adobe.pdf"
        
        if #available(iOS 14.0, *) {
            let documentTypes = UTType.types(tag: "pdf", tagClass: UTTagClass.filenameExtension, conformingTo: nil)
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: documentTypes)
        } else {
            documentPicker = UIDocumentPickerViewController(documentTypes: [pdfType], in: .import)
        }
        
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        displayPDF(url: url)
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func displayPDF(url: URL) {
        guard let pdfDocument = PDFDocument(url: url) else {
            print("Failed to load the PDF document.")
            return
        }
        pdfView.document = pdfDocument
        // Enable automatic scaling of the PDF view to fit the content within the available space
        pdfView.autoScales = true
    }
}

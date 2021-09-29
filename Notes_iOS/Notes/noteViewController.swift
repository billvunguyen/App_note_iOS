//
//  ViewController.swift
//  Notes
//
//  Created by Bill on 11/18/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit
import CoreData



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class noteViewController: UIViewController, UITextFieldDelegate,  UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var noteInfoView: UIView!
    @IBOutlet weak var noteImageViewView: UIView!
    
    @IBOutlet weak var noteNameLabel: UITextField!
    @IBOutlet weak var noteDescriptionLabel: UITextView!
    
    @IBOutlet weak var noteImageView: UIImageView!
    
    @IBOutlet weak var noteTimeStart: UITextField!
    @IBOutlet weak var noteTimeEnd: UITextField!
    @IBOutlet weak var noteTimeStart_1: UITextField!
    @IBOutlet weak var noteTimeEnd_1: UITextField!
    @IBOutlet weak var noteTimeStart_2: UITextField!
    @IBOutlet weak var noteTimeEnd_2: UITextField!
    @IBOutlet weak var noteTimeStart_3: UITextField!
    @IBOutlet weak var noteTimeEnd_3: UITextField!
    @IBOutlet weak var noteTimeStart_4: UITextField!
    @IBOutlet weak var noteTimeEnd_4: UITextField!
    @IBOutlet weak var noteTimeStart_5: UITextField!
    @IBOutlet weak var noteTimeEnd_5: UITextField!
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblTime_1: UILabel!
    @IBOutlet weak var lblTime_2: UILabel!
    @IBOutlet weak var lblTime_3: UILabel!
    @IBOutlet weak var lblTime_4: UILabel!
    @IBOutlet weak var lblTime_5: UILabel!
    @IBOutlet weak var lblTotalTime: UILabel!
    
    
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }
    
    let datePickerTimeStart = UIDatePicker()
    let datePickerTimeEnd = UIDatePicker()
    let datePickerTimeStart_1 = UIDatePicker()
    let datePickerTimeEnd_1 = UIDatePicker()
    let datePickerTimeStart_2 = UIDatePicker()
    let datePickerTimeEnd_2 = UIDatePicker()
    let datePickerTimeStart_3 = UIDatePicker()
    let datePickerTimeEnd_3 = UIDatePicker()
    let datePickerTimeStart_4 = UIDatePicker()
    let datePickerTimeEnd_4 = UIDatePicker()
    let datePickerTimeStart_5 = UIDatePicker()
    let datePickerTimeEnd_5 = UIDatePicker()
    
    var noteTime: Double = 0
    var noteTime_1: Double = 0
    var noteTime_2: Double = 0
    var noteTime_3: Double = 0
    var noteTime_4: Double = 0
    var noteTime_5: Double = 0
    var noteTotalTime: Double = 0
    
    var notesFetchedResultsController: NSFetchedResultsController<Note>!
    var notes = [Note]()
    var note: Note?
    var isExsisting = false
    var indexPath: Int?
    
    var txtNoteTime:String = ""
    var txtNoteTime_1:String = ""
    var txtNoteTime_2:String = ""
    var txtNoteTime_3:String = ""
    var txtNoteTime_4:String = ""
    var txtNoteTime_5:String = ""
    var txtNoteTotalTime:String = ""
    
    let formatter = DateFormatter()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Load data
        if let note = note {
            noteNameLabel.text = note.noteName
            noteDescriptionLabel.text = note.noteDescription
            noteImageView.image = UIImage(data: note.noteImage! as Data)
            
            formatter.dateFormat = "E, MMM dd | HH:mm"

            if checkDate(noteTimeStart: note.noteTimeStart!, noteTimeEnd: note.noteTimeEnd!) == true {
                noteTimeStart.text = "No Data"
                noteTimeEnd.text = "No Data"
            } else {
                noteTimeStart.text = formatter.string(from: note.noteTimeStart!)
                noteTimeEnd.text = formatter.string(from: note.noteTimeEnd!)
            }
            
            if checkDate(noteTimeStart: note.noteTimeStart_1!, noteTimeEnd: note.noteTimeEnd_1!) == true {
                noteTimeStart_1.text = "No Data"
                noteTimeEnd_1.text = "No Data"
            } else {
                noteTimeStart_1.text = formatter.string(from: note.noteTimeStart_1!)
                noteTimeEnd_1.text = formatter.string(from: note.noteTimeEnd_1!)
            }
            
            if checkDate(noteTimeStart: note.noteTimeStart_2!, noteTimeEnd: note.noteTimeEnd_2!) == true {
                noteTimeStart_2.text = "No Data"
                noteTimeEnd_2.text = "No Data"
            } else {
                noteTimeStart_2.text = formatter.string(from: note.noteTimeStart_2!)
                noteTimeEnd_2.text = formatter.string(from: note.noteTimeEnd_2!)
            }
            
            if checkDate(noteTimeStart: note.noteTimeStart_3!, noteTimeEnd: note.noteTimeEnd_3!) == true {
                noteTimeStart_3.text = "No Data"
                noteTimeEnd_3.text = "No Data"
            } else {
                noteTimeStart_3.text = formatter.string(from: note.noteTimeStart_3!)
                noteTimeEnd_3.text = formatter.string(from: note.noteTimeEnd_3!)
            }
            if checkDate(noteTimeStart: note.noteTimeStart_4!, noteTimeEnd: note.noteTimeEnd_4!) == true {
                noteTimeStart_4.text = "No Data"
                noteTimeEnd_4.text = "No Data"
            } else {
                noteTimeStart_4.text = formatter.string(from: note.noteTimeStart_4!)
                noteTimeEnd_4.text = formatter.string(from: note.noteTimeEnd_4!)
            }
            if checkDate(noteTimeStart: note.noteTimeStart_5!, noteTimeEnd: note.noteTimeEnd_5!) == true {
                noteTimeStart_5.text = "No Data"
                noteTimeEnd_5.text = "No Data"
            } else {
                noteTimeStart_5.text = formatter.string(from: note.noteTimeStart_5!)
                noteTimeEnd_5.text = formatter.string(from: note.noteTimeEnd_5!)
            }
            
            
            
            txtNoteTime = String(format: "%.1f" ,note.noteTime)
            lblTime.text = "Time : " + txtNoteTime + " hours"
            
            txtNoteTime_1 = String(format: "%.1f" ,note.noteTime_1)
            lblTime_1.text = "Time 1 : " + txtNoteTime_1 + " hours"
            
            txtNoteTime_2 = String(format: "%.1f" ,note.noteTime_2)
            lblTime_2.text = "Time 2 : " + txtNoteTime_2 + " hours"
            
            txtNoteTime_3 = String(format: "%.1f" ,note.noteTime_3)
            lblTime_3.text = "Time 3 : " + txtNoteTime_3 + " hours"
            
            txtNoteTime_4 = String(format: "%.1f" ,note.noteTime_4)
            lblTime_4.text = "Time 4 : " + txtNoteTime_4 + " hours"
            
            txtNoteTime_5 = String(format: "%.1f" ,note.noteTime_5)
            lblTime_5.text = "Time 5 : " + txtNoteTime_5 + " hours"
            
            txtNoteTotalTime = String(format: "%.1f" ,note.noteTotalTime)
            lblTotalTime.text = "Total Time : " + txtNoteTotalTime + " hours"

            
        }
        
        if noteNameLabel.text != "" {
            isExsisting = true
        }
        
        // Delegates
        noteNameLabel.delegate = self
        noteDescriptionLabel.delegate = self
        noteTimeStart.delegate = self
        noteTimeEnd.delegate = self
        noteTimeStart_1.delegate = self
        noteTimeEnd_1.delegate = self
        noteTimeStart_2.delegate = self
        noteTimeEnd_2.delegate = self
        noteTimeStart_3.delegate = self
        noteTimeEnd_3.delegate = self
        noteTimeStart_4.delegate = self
        noteTimeEnd_4.delegate = self
        noteTimeStart_5.delegate = self
        noteTimeEnd_5.delegate = self
        
        // Styles
        noteInfoView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        noteInfoView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        noteInfoView.layer.shadowRadius = 1.5
        noteInfoView.layer.shadowOpacity = 0.2
        noteInfoView.layer.cornerRadius = 2
        
        noteImageViewView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        noteImageViewView.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        noteImageViewView.layer.shadowRadius = 1.5
        noteImageViewView.layer.shadowOpacity = 0.2
        noteImageViewView.layer.cornerRadius = 2
        
        noteImageView.layer.cornerRadius = 2
        
        noteNameLabel.setBottomBorder()
        noteDescriptionLabel.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor(red: 245.0/255.0, green: 79.0/255.0, blue: 80.0/255.0, alpha: 1.0), thickness: 2)
        
        createDatePickerTimeStart()
        createDatePickerTimeEnd()
        createDatePickerTimeStart_1()
        createDatePickerTimeEnd_1()
        createDatePickerTimeStart_2()
        createDatePickerTimeEnd_2()
        createDatePickerTimeStart_3()
        createDatePickerTimeEnd_3()
        createDatePickerTimeStart_4()
        createDatePickerTimeEnd_4()
        createDatePickerTimeStart_5()
        createDatePickerTimeEnd_5()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    // Core data
    func saveToCoreData(completion: @escaping ()->Void){
        managedObjectContext!.perform {
            do {
                try self.managedObjectContext?.save()
                completion()
                print("Note saved to CoreData.")
                
            }
            
            catch let error {
                print("Could not save note to CoreData: \(error.localizedDescription)")
                
            }
            
        }
        
    }
    
    // Image Picker
    @IBAction func pickImageButtonWasPressed(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add an Image", message: "Choose From", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.noteImageView.image = image
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }

    // Save
    @IBAction func saveButtonWasPressed(_ sender: UIBarButtonItem) {
        if noteNameLabel.text == "" || noteNameLabel.text == "NOTE NAME" {
            
            let alertController = UIAlertController(title: "Missing Information", message:"You left one or more fields empty. Please make sure that all fields are filled before attempting to save.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        else {
            if (isExsisting == false) {
                let noteName = noteNameLabel.text
                let noteDescription = noteDescriptionLabel.text
                
                let noteTimeStart = datePickerTimeStart.date
                let noteTimeEnd = datePickerTimeEnd.date
                
                let noteTimeStart_1 = datePickerTimeStart_1.date
                let noteTimeEnd_1 = datePickerTimeEnd_1.date
                
                let noteTimeStart_2 = datePickerTimeStart_2.date
                let noteTimeEnd_2 = datePickerTimeEnd_2.date
                
                let noteTimeStart_3 = datePickerTimeStart_3.date
                let noteTimeEnd_3 = datePickerTimeEnd_3.date
                
                let noteTimeStart_4 = datePickerTimeStart_4.date
                let noteTimeEnd_4 = datePickerTimeEnd_4.date
                
                let noteTimeStart_5 = datePickerTimeStart_5.date
                let noteTimeEnd_5 = datePickerTimeEnd_5.date
                
                if let moc = managedObjectContext {
                    let note = Note(context: moc)

                    if let data = UIImageJPEGRepresentation(self.noteImageView.image!, 1.0) {
                        note.noteImage = data as NSData as Data
                    }
                
                    note.noteName = noteName
                    note.noteDescription = noteDescription
                    
                    //-----------Time---------//
                    
                    // Pick Time
                    note.noteTimeStart = noteTimeStart
                    note.noteTimeEnd = noteTimeEnd
                    
                    // Pick Time 1
                    note.noteTimeStart_1 = noteTimeStart_1
                    note.noteTimeEnd_1 = noteTimeEnd_1
                    
                    // Pick Time 2
                    note.noteTimeStart_2 = noteTimeStart_2
                    note.noteTimeEnd_2 = noteTimeEnd_2
                    
                    // Pick Time 3
                    note.noteTimeStart_3 = noteTimeStart_3
                    note.noteTimeEnd_3 = noteTimeEnd_3
                    
                    // Pick Time 4
                    note.noteTimeStart_4 = noteTimeStart_4
                    note.noteTimeEnd_4 = noteTimeEnd_4
                    
                    // Pick Time 5
                    note.noteTimeStart_5 = noteTimeStart_5
                    note.noteTimeEnd_5 = noteTimeEnd_5
                    
                    // Note Time
                    note.noteTime = noteTime
                    note.noteTime_1 = noteTime_1
                    note.noteTime_2 = noteTime_2
                    note.noteTime_3 = noteTime_3
                    note.noteTime_4 = noteTime_4
                    note.noteTime_5 = noteTime_5
                    
                    note.noteTotalTime = noteTotalTime
                
                    saveToCoreData() {
                        
                        let isPresentingInAddFluidPatientMode = self.presentingViewController is UINavigationController
                        
                        if isPresentingInAddFluidPatientMode {
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                        else {
                            self.navigationController!.popViewController(animated: true)
                            
                        }

                    }

                }
            }
            
            else if (isExsisting == true) {
                
                let note = self.note
                formatter.dateFormat = "E, MMM dd | HH:mm"
                
                let managedObject = note
                managedObject!.setValue(noteNameLabel.text, forKey: "noteName")
                managedObject!.setValue(noteDescriptionLabel.text, forKey: "noteDescription")
                
                //---- Time ----//

                if checkTimeString(Time1: noteTimeStart.text!, Time2: note!.noteTimeStart!) == true{
                    managedObject!.setValue(note!.noteTimeStart, forKey: "noteTimeStart")
                }else {
                    managedObject!.setValue(datePickerTimeStart.date, forKey: "noteTimeStart")
                }
                if checkTimeString(Time1: noteTimeEnd.text!, Time2: note!.noteTimeEnd!) == true{
                    managedObject!.setValue(note!.noteTimeEnd, forKey: "noteTimeEnd")
                }else {
                    managedObject!.setValue(datePickerTimeEnd.date, forKey: "noteTimeEnd")
                }
                if checkDurationTimeString(noteTime1: txtNoteTime, noteTime2: note!.noteTime) == true {
                    managedObject!.setValue(note!.noteTime, forKey: "noteTime")
                } else {
                    managedObject!.setValue(noteTime, forKey: "noteTime")
                }
            
                //---- Time 1 ----//
                
                if checkTimeString(Time1: noteTimeStart_1.text!, Time2: note!.noteTimeStart_1!) == true{
                    managedObject!.setValue(note!.noteTimeStart_1, forKey: "noteTimeStart_1")
                }else {
                    managedObject!.setValue(datePickerTimeStart_1.date, forKey: "noteTimeStart_1")
                }
                if checkTimeString(Time1: noteTimeEnd_1.text!, Time2: note!.noteTimeEnd_1!) == true {
                    managedObject!.setValue(note!.noteTimeEnd_1, forKey: "noteTimeEnd_1")
                } else {
                    managedObject!.setValue(datePickerTimeEnd_1.date, forKey: "noteTimeEnd_1")
                }
                if checkDurationTimeString(noteTime1: txtNoteTime_1, noteTime2: note!.noteTime_1) == true {
                    managedObject!.setValue(note!.noteTime_1, forKey: "noteTime_1")
                } else {
                    managedObject!.setValue(noteTime_1, forKey: "noteTime_1")
                }
                
                //---- Time 2 ----//
                
                if checkTimeString(Time1: noteTimeStart_2.text!, Time2: note!.noteTimeStart_2!) == true{
                    managedObject!.setValue(note!.noteTimeStart_2, forKey: "noteTimeStart_2")
                }else {
                    managedObject!.setValue(datePickerTimeStart_2.date, forKey: "noteTimeStart_2")
                }
                if checkTimeString(Time1: noteTimeEnd_2.text!, Time2: note!.noteTimeEnd_2!) == true {
                    managedObject!.setValue(note!.noteTimeEnd_2, forKey: "noteTimeEnd_2")
                } else {
                    managedObject!.setValue(datePickerTimeEnd_2.date, forKey: "noteTimeEnd_2")
                }
                if checkDurationTimeString(noteTime1: txtNoteTime_2, noteTime2: note!.noteTime_2) == true {
                    managedObject!.setValue(note!.noteTime_2, forKey: "noteTime_2")
                } else {
                    managedObject!.setValue(noteTime_2, forKey: "noteTime_2")
                }
                
                //---- Time 3 ----//
                
                if checkTimeString(Time1: noteTimeStart_3.text!, Time2: note!.noteTimeStart_3!) == true{
                    managedObject!.setValue(note!.noteTimeStart_3, forKey: "noteTimeStart_3")
                }else {
                    managedObject!.setValue(datePickerTimeStart_3.date, forKey: "noteTimeStart_3")
                }
                if checkTimeString(Time1: noteTimeEnd_3.text!, Time2: note!.noteTimeEnd_3!) == true {
                    managedObject!.setValue(note!.noteTimeEnd_3, forKey: "noteTimeEnd_3")
                } else {
                    managedObject!.setValue(datePickerTimeEnd_3.date, forKey: "noteTimeEnd_3")
                }
                if checkDurationTimeString(noteTime1: txtNoteTime_3, noteTime2: note!.noteTime_3) == true {
                    managedObject!.setValue(note!.noteTime_3, forKey: "noteTime_3")
                } else {
                    managedObject!.setValue(noteTime_3, forKey: "noteTime_3")
                }
                
                //---- Time 4 ----//
                
                if checkTimeString(Time1: noteTimeStart_4.text!, Time2: note!.noteTimeStart_4!) == true{
                    managedObject!.setValue(note!.noteTimeStart_4, forKey: "noteTimeStart_4")
                }else {
                    managedObject!.setValue(datePickerTimeStart_4.date, forKey: "noteTimeStart_4")
                }
                if checkTimeString(Time1: noteTimeEnd_4.text!, Time2: note!.noteTimeEnd_4!) == true {
                    managedObject!.setValue(note!.noteTimeEnd_4, forKey: "noteTimeEnd_4")
                } else {
                    managedObject!.setValue(datePickerTimeEnd_4.date, forKey: "noteTimeEnd_4")
                }
                if checkDurationTimeString(noteTime1: txtNoteTime_4, noteTime2: note!.noteTime_4) == true {
                    managedObject!.setValue(note!.noteTime_4, forKey: "noteTime_4")
                } else {
                    managedObject!.setValue(noteTime_4, forKey: "noteTime_4")
                }
                
                //---- Time 5 ----//
                
                if checkTimeString(Time1: noteTimeStart_5.text!, Time2: note!.noteTimeStart_5!) == true{
                    managedObject!.setValue(note!.noteTimeStart_5, forKey: "noteTimeStart_5")
                }else {
                    managedObject!.setValue(datePickerTimeStart_5.date, forKey: "noteTimeStart_5")
                }
                if checkTimeString(Time1: noteTimeEnd_5.text!, Time2: note!.noteTimeEnd_5!) == true {
                    managedObject!.setValue(note!.noteTimeEnd_5, forKey: "noteTimeEnd_5")
                } else {
                    managedObject!.setValue(datePickerTimeEnd_5.date, forKey: "noteTimeEnd_5")
                }
                if checkDurationTimeString(noteTime1: txtNoteTime_5, noteTime2: note!.noteTime_5) == true {
                    managedObject!.setValue(note!.noteTime_5, forKey: "noteTime_5")
                } else {
                    managedObject!.setValue(noteTime_5, forKey: "noteTime_5")
                }
                
                //---- Total Time ----//
                if checkDurationTimeString(noteTime1: txtNoteTotalTime, noteTime2: note!.noteTotalTime) ==  true {
                    managedObject!.setValue(note!.noteTotalTime, forKey: "noteTotalTime")
                } else {
                    managedObject!.setValue(noteTotalTime, forKey: "noteTotalTime")
                }
                
                if let data = UIImageJPEGRepresentation(self.noteImageView.image!, 1.0) {
                    managedObject!.setValue(data, forKey: "noteImage")
                }
                
                do {
                    try context.save()
                    
                    let isPresentingInAddFluidPatientMode = self.presentingViewController is UINavigationController
                    
                    if isPresentingInAddFluidPatientMode {
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                        
                    else {
                        self.navigationController!.popViewController(animated: true)
                        
                    }

                }
                
                catch {
                    print("Failed to update existing note.")
                }
            }

        }

    }
    
    
    
    // Cancel
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddFluidPatientMode = presentingViewController is UINavigationController
        
        if isPresentingInAddFluidPatientMode {
            dismiss(animated: true, completion: nil)
            
        }
        
        else {
            navigationController!.popViewController(animated: true)
            
        }
        
    }
    
    // Text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
            
        }
        
        return true
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Note Description...") {
            textView.text = ""
            
        }
        
    }
    
    //-----------------------------Time---------------------------------------//
    //------------------------Time Start---------------------------------//
    func createDatePickerTimeStart() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeStart.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart.preferredDatePickerStyle = .wheels
            datePickerTimeStart.preferredDatePickerStyle = .wheels
        }
        
        noteTimeStart.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeStart))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeStart.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeStart.inputView = datePickerTimeStart
        datePickerTimeStart.datePickerMode = .dateAndTime
        datePickerTimeStart.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeStart() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        noteTimeStart.text = formatterDay.string(from: datePickerTimeStart.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeEnd.text == formatterDay.string(from: note!.noteTimeEnd!))  {
            datePickerTimeEnd.date = note!.noteTimeEnd!
        }
        
        noteTime = calcuTime(Time1: datePickerTimeStart.date, Time2: datePickerTimeEnd.date)
        txtNoteTime = String(format: "%.1f",Double(noteTime))
        lblTime.text = "Time : " + txtNoteTime + " hour"
        if noteTime <= 0 {
            noteTime = 0
            lblTime.text = "Time : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    func createDatePickerTimeEnd() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeEnd.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd.preferredDatePickerStyle = .wheels
            datePickerTimeEnd.preferredDatePickerStyle = .wheels
        }
        
        noteTimeEnd.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeEnd))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeEnd.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeEnd.inputView = datePickerTimeEnd
        
        datePickerTimeEnd.datePickerMode = .dateAndTime
        datePickerTimeEnd.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeEnd() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeEnd.text = formatterDay.string(from: datePickerTimeEnd.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeStart.text == formatterDay.string(from: note!.noteTimeStart!)) {
            datePickerTimeStart.date = note!.noteTimeStart!
        }
        
        noteTime = calcuTime(Time1: datePickerTimeStart.date, Time2: datePickerTimeEnd.date)
        txtNoteTime = String(format: "%.1f",Double(noteTime))
        lblTime.text = "Time : " + txtNoteTime + " hours"
        if noteTime <= 0 {
            noteTime = 0
            lblTime.text = "Time : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    //-----------------------------Time 1---------------------------------------//
    //------------------------Time Start---------------------------------//
    func createDatePickerTimeStart_1() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeStart_1.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_1.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_1.preferredDatePickerStyle = .wheels
            datePickerTimeStart_1.preferredDatePickerStyle = .wheels
        }
        
        noteTimeStart_1.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeStart_1))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeStart_1.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeStart_1.inputView = datePickerTimeStart_1
        
        datePickerTimeStart_1.datePickerMode = .dateAndTime
        datePickerTimeStart_1.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeStart_1() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeStart_1.text = formatterDay.string(from: datePickerTimeStart_1.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeEnd_1.text == formatterDay.string(from: note!.noteTimeEnd_1!))  {
            datePickerTimeEnd_1.date = note!.noteTimeEnd_1!
        }
        
        noteTime_1 = calcuTime(Time1: datePickerTimeStart_1.date, Time2: datePickerTimeEnd_1.date)
        txtNoteTime_1 = String(format: "%.1f",Double(noteTime_1))
        lblTime_1.text = "Time : " + txtNoteTime_1 + " hours"
        if noteTime_1 <= 0 {
            noteTime_1 = 0
            lblTime_1.text = "Time : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    func createDatePickerTimeEnd_1() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeEnd_1.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_1.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_1.preferredDatePickerStyle = .wheels
            datePickerTimeEnd_1.preferredDatePickerStyle = .wheels
        }
        
        noteTimeEnd_1.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeEnd_1))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeEnd_1.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeEnd_1.inputView = datePickerTimeEnd_1
        
        datePickerTimeEnd_1.datePickerMode = .dateAndTime
        datePickerTimeEnd_1.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeEnd_1() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeEnd_1.text = formatterDay.string(from: datePickerTimeEnd_1.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeStart_1.text == formatterDay.string(from: note!.noteTimeStart_1!)) {
            datePickerTimeStart_1.date = note!.noteTimeStart_1!
        }
        
        noteTime_1 = calcuTime(Time1: datePickerTimeStart_1.date, Time2: datePickerTimeEnd_1.date)
        txtNoteTime_1 = String(format: "%.1f",Double(noteTime_1))
        lblTime_1.text = "Time 1 : " + txtNoteTime_1 + " hours"
        if noteTime_1 <= 0 {
            noteTime_1 = 0
            lblTime_1.text = "Time 1 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    //-----------------------------Time 2---------------------------------------//
    //------------------------Time Start---------------------------------//
    func createDatePickerTimeStart_2() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeStart_2.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_2.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_2.preferredDatePickerStyle = .wheels
            datePickerTimeStart_2.preferredDatePickerStyle = .wheels
        }
        
        noteTimeStart_2.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeStart_2))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeStart_2.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeStart_2.inputView = datePickerTimeStart_2
        
        datePickerTimeStart_2.datePickerMode = .dateAndTime
        datePickerTimeStart_2.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeStart_2() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeStart_2.text = formatterDay.string(from: datePickerTimeStart_2.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeEnd_2.text == formatterDay.string(from: note!.noteTimeEnd_2!))  {
            datePickerTimeEnd_2.date = note!.noteTimeEnd_2!
        }
        
        noteTime_2 = calcuTime(Time1: datePickerTimeStart_2.date, Time2: datePickerTimeEnd_2.date)
        txtNoteTime_2 = String(format: "%.1f",Double(noteTime_2))
        lblTime_2.text = "Time 2 : " + txtNoteTime_2 + " hours"
        if noteTime_2 <= 0 {
            noteTime_2 = 0
            lblTime_2.text = "Time 2 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    func createDatePickerTimeEnd_2() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeEnd_2.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_2.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_2.preferredDatePickerStyle = .wheels
            datePickerTimeEnd_2.preferredDatePickerStyle = .wheels
        }
        
        noteTimeEnd_2.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeEnd_2))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeEnd_2.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeEnd_2.inputView = datePickerTimeEnd_2
        
        datePickerTimeEnd_2.datePickerMode = .dateAndTime
        datePickerTimeEnd_2.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeEnd_2() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeEnd_2.text = formatterDay.string(from: datePickerTimeEnd_2.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeStart_2.text == formatterDay.string(from: note!.noteTimeStart_2!)) {
            datePickerTimeStart_2.date = note!.noteTimeStart_2!
        }
        
        noteTime_2 = calcuTime(Time1: datePickerTimeStart_2.date, Time2: datePickerTimeEnd_2.date)
        txtNoteTime_2 = String(format: "%.1f",Double(noteTime_2))
        lblTime_2.text = "Time 2 : " + txtNoteTime_2 + " hours"
        if noteTime_2 <= 0 {
            noteTime_2 = 0
            lblTime_2.text = "Time 2 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    //-----------------------------Time 3---------------------------------------//
    //------------------------Time Start---------------------------------//
    func createDatePickerTimeStart_3() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeStart_3.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_3.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_3.preferredDatePickerStyle = .wheels
            datePickerTimeStart_3.preferredDatePickerStyle = .wheels
        }
        
        noteTimeStart_3.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeStart_3))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeStart_3.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeStart_3.inputView = datePickerTimeStart_3
        
        datePickerTimeStart_3.datePickerMode = .dateAndTime
        datePickerTimeStart_3.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeStart_3() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeStart_3.text = formatterDay.string(from: datePickerTimeStart_3.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeEnd_3.text == formatterDay.string(from: note!.noteTimeEnd_3!))  {
            datePickerTimeEnd_3.date = note!.noteTimeEnd_3!
        }
        
        noteTime_3 = calcuTime(Time1: datePickerTimeStart_3.date, Time2: datePickerTimeEnd_3.date)
        txtNoteTime_3 = String(format: "%.1f",Double(noteTime_3))
        lblTime_3.text = "Time 3 : " + txtNoteTime_3 + " hours"
        if noteTime_3 <= 0 {
            noteTime_3 = 0
            lblTime_3.text = "Time 3 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    func createDatePickerTimeEnd_3() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeEnd_3.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_3.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_3.preferredDatePickerStyle = .wheels
            datePickerTimeEnd_3.preferredDatePickerStyle = .wheels
        }
        
        noteTimeEnd_3.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeEnd_3))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeEnd_3.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeEnd_3.inputView = datePickerTimeEnd_3
        
        datePickerTimeEnd_3.datePickerMode = .dateAndTime
        datePickerTimeEnd_3.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeEnd_3() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeEnd_3.text = formatterDay.string(from: datePickerTimeEnd_3.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeStart_3.text == formatterDay.string(from: note!.noteTimeStart_3!)) {
            datePickerTimeStart_3.date = note!.noteTimeStart_3!
        }
        
        noteTime_3 = calcuTime(Time1: datePickerTimeStart_3.date, Time2: datePickerTimeEnd_3.date)
        txtNoteTime_3 = String(format: "%.1f",Double(noteTime_3))
        lblTime_3.text = "Time 3 : " + txtNoteTime_3 + " hours"
        if noteTime_3 <= 0 {
            noteTime_3 = 0
            lblTime_3.text = "Time 3 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    //-----------------------------Time 4---------------------------------------//
    //------------------------Time Start---------------------------------//
    func createDatePickerTimeStart_4() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeStart_4.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_4.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_4.preferredDatePickerStyle = .wheels
            datePickerTimeStart_4.preferredDatePickerStyle = .wheels
        }
        
        noteTimeStart_4.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeStart_4))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeStart_4.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeStart_4.inputView = datePickerTimeStart_4
        
        datePickerTimeStart_4.datePickerMode = .dateAndTime
        datePickerTimeStart_4.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeStart_4() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeStart_4.text = formatterDay.string(from: datePickerTimeStart_4.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeEnd_4.text == formatterDay.string(from: note!.noteTimeEnd_4!))  {
            datePickerTimeEnd_4.date = note!.noteTimeEnd_4!
        }
        
        noteTime_4 = calcuTime(Time1: datePickerTimeStart_4.date, Time2: datePickerTimeEnd_4.date)
        txtNoteTime_4 = String(format: "%.1f",Double(noteTime_4))
        lblTime_4.text = "Time 4 : " + txtNoteTime_4 + " hours"
        if noteTime_4 <= 0 {
            noteTime_4 = 0
            lblTime_4.text = "Time 4 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    func createDatePickerTimeEnd_4() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeEnd_4.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_4.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_4.preferredDatePickerStyle = .wheels
            datePickerTimeEnd_4.preferredDatePickerStyle = .wheels
        }
        
        noteTimeEnd_4.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeEnd_4))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeEnd_4.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeEnd_4.inputView = datePickerTimeEnd_4
        
        datePickerTimeEnd_4.datePickerMode = .dateAndTime
        datePickerTimeEnd_4.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeEnd_4() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeEnd_4.text = formatterDay.string(from: datePickerTimeEnd_4.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeStart_4.text == formatterDay.string(from: note!.noteTimeStart_4!)) {
            datePickerTimeStart_4.date = note!.noteTimeStart_4!
        }
        
        noteTime_4 = calcuTime(Time1: datePickerTimeStart_4.date, Time2: datePickerTimeEnd_4.date)
        txtNoteTime_4 = String(format: "%.1f",Double(noteTime_4))
        lblTime_4.text = "Time 4 : " + txtNoteTime_4 + " hours"
        if noteTime_4 <= 0 {
            noteTime_4 = 0
            lblTime_4.text = "Time 4 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    //-----------------------------Time 5---------------------------------------//
    //------------------------Time Start---------------------------------//
    func createDatePickerTimeStart_5() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeStart_5.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_5.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeStart_5.preferredDatePickerStyle = .wheels
            datePickerTimeStart_5.preferredDatePickerStyle = .wheels
        }
        
        noteTimeStart_5.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeStart_5))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeStart_5.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeStart_5.inputView = datePickerTimeStart_5
        
        datePickerTimeStart_5.datePickerMode = .dateAndTime
        datePickerTimeStart_5.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeStart_5() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeStart_5.text = formatterDay.string(from: datePickerTimeStart_5.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeEnd_5.text == formatterDay.string(from: note!.noteTimeEnd_5!))  {
            datePickerTimeEnd_5.date = note!.noteTimeEnd_5!
        }
        
        noteTime_5 = calcuTime(Time1: datePickerTimeStart_5.date, Time2: datePickerTimeEnd_5.date)
        txtNoteTime_5 = String(format: "%.1f",Double(noteTime_5))
        lblTime_5.text = "Time 5 : " + txtNoteTime_5 + " hours"
        if noteTime_5 <= 0 {
            noteTime_5 = 0
            lblTime_5.text = "Time 5 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    func createDatePickerTimeEnd_5() {
        
        if #available(iOS 13.4, *) {
            datePickerTimeEnd_5.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_5.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
            datePickerTimeEnd_5.preferredDatePickerStyle = .wheels
            datePickerTimeEnd_5.preferredDatePickerStyle = .wheels
        }
        
        noteTimeEnd_5.textAlignment = .center
        
        // toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePresseTimeEnd_5))
        toolbar.setItems([doneBtn], animated: true)
        
        // assign toolbar
        noteTimeEnd_5.inputAccessoryView = toolbar
        
        // assign date picker to the text field
        noteTimeEnd_5.inputView = datePickerTimeEnd_5
        
        datePickerTimeEnd_5.datePickerMode = .dateAndTime
        datePickerTimeEnd_5.locale = Locale(identifier: "en_GB")
        
    }
    
    @objc func donePresseTimeEnd_5() {
        //formatter
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "E, MMM dd | HH:mm"
        
        noteTimeEnd_5.text = formatterDay.string(from: datePickerTimeEnd_5.date)
        self.view.endEditing(true)
        
        if isExsisting == true && (noteTimeStart_5.text == formatterDay.string(from: note!.noteTimeStart_5!)) {
            datePickerTimeStart_5.date = note!.noteTimeStart_5!
        }
        
        noteTime_5 = calcuTime(Time1: datePickerTimeStart_5.date, Time2: datePickerTimeEnd_5.date)
        txtNoteTime_5 = String(format: "%.1f",Double(noteTime_5))
        lblTime_5.text = "Time 5 : " + txtNoteTime_5 + " hours"
        if noteTime_5 <= 0 {
            noteTime_5 = 0
            lblTime_5.text = "Time 5 : 0.0 hour"
        }
        calcuTotalTime()
    }
    
    //---------------------------- Calculation-----------------------------------//
    
    func calcuTime(Time1:Date, Time2:Date) -> Double{
        let totalTime = Double(round(Time2.timeIntervalSince1970) - round(Time1.timeIntervalSince1970)) / 3600
        return totalTime
    }
    
    func calcuTotalTime () {
        if isExsisting == true && txtNoteTime == String(format: "%.1f" ,note!.noteTime) {
            noteTime = note!.noteTime
        }
        if isExsisting == true && txtNoteTime_1 == String(format: "%.1f" ,note!.noteTime_1) {
            noteTime_1 = note!.noteTime_1
        }
        if isExsisting == true && txtNoteTime_2 == String(format: "%.1f" ,note!.noteTime_2) {
            noteTime_2 = note!.noteTime_2
        }
        if isExsisting == true && txtNoteTime_3 == String(format: "%.1f" ,note!.noteTime_3) {
            noteTime_3 = note!.noteTime_3
        }
        if isExsisting == true && txtNoteTime_4 == String(format: "%.1f" ,note!.noteTime_4) {
            noteTime_4 = note!.noteTime_4
        }
        if isExsisting == true && txtNoteTime_5 == String(format: "%.1f" ,note!.noteTime_5) {
            noteTime_5 = note!.noteTime_5
        }
        noteTotalTime = noteTime + noteTime_1 + noteTime_2 + noteTime_3 + noteTime_4 + noteTime_5
        txtNoteTotalTime = String(format: "%.1f",Double(noteTotalTime))
        lblTotalTime.text = "Total Time : " + txtNoteTotalTime + " hours"
    }
    
    // Check Time
    
    func checkDate(noteTimeStart:Date, noteTimeEnd:Date) -> Bool {
        var bool = false
        formatter.dateFormat = "E, MMM dd | HH:mm"
        if formatter.string(from: noteTimeStart) == formatter.string(from: noteTimeEnd) {
            bool = true
        }
        return bool
    }
    
    func checkTimeString(Time1:String, Time2:Date) -> Bool {
        formatter.dateFormat = "E, MMM dd | HH:mm"
        var bool = false
        
        if Time1 == formatter.string(from: Time2) {
            bool = true
        }
        return bool
    }
    
    func checkDurationTimeString(noteTime1:String, noteTime2:Double) -> Bool {
        var bool = false
        
        if noteTime1 == String(format: "%.1f" , noteTime2) {
            bool = true
        }
        return bool
    }
    
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 245.0/255.0, green: 79.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}


extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.zero
            border.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.bounds.height - thickness, width: self.bounds.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.bounds.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.bounds.width - thickness, y: 0, width: thickness, height: self.bounds.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}

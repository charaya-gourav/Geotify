

import UIKit
import MapKit

protocol AddGeotificationsViewControllerDelegate {
  func addGeotificationViewController(controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
    radius: Double, identifier: String, note: String)
}

class AddGeotificationViewController: UITableViewController {

  @IBOutlet var addButton: UIBarButtonItem!
  @IBOutlet var zoomButton: UIBarButtonItem!

  @IBOutlet weak var radiusTextField: UITextField!
  @IBOutlet weak var noteTextField: UITextField!
  @IBOutlet weak var mapView: MKMapView!

  var delegate: AddGeotificationsViewControllerDelegate!

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.rightBarButtonItems = [addButton, zoomButton]
    addButton.enabled = false

    tableView.tableFooterView = UIView()
  }

  @IBAction func textFieldEditingChanged(sender: UITextField) {
    addButton.enabled = !radiusTextField.text!.isEmpty && !noteTextField.text!.isEmpty
  }

  @IBAction func onCancel(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

  @IBAction private func onAdd(sender: AnyObject) {
    let coordinate = mapView.centerCoordinate
    let radius = (radiusTextField.text! as NSString).doubleValue
    let identifier = NSUUID().UUIDString
    let note = noteTextField.text
    delegate!.addGeotificationViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note!)
  }

  @IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
    zoomToUserLocationInMapView(mapView)
  }
}

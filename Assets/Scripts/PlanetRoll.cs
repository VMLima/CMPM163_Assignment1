using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlanetRoll : MonoBehaviour {
    bool hasGrabbedPoint = false;
    Vector3 grabbedPoint;
    // Start is called before the first frame update
    void Start() {
        
    }

    // Update is called once per frame
    void Update() {
        if (Input.GetMouseButton(0)) {
            if (!hasGrabbedPoint) {
                hasGrabbedPoint = true;
                grabbedPoint = getTouchedPoint();
            } else {
                Vector3 targetPoint = getTouchedPoint();
                Quaternion rot = Quaternion.FromToRotation(grabbedPoint, targetPoint);
                transform.localRotation *= rot;
            }
        } else {
            hasGrabbedPoint = false;
        }
    }


    Vector3 getTouchedPoint() {
        RaycastHit hit;
        Physics.Raycast(Camera.main.ScreenPointToRay(Input.mousePosition), out hit);
        


        return transform.InverseTransformPoint(hit.point);

    }

    private void OnMouseDown() {

    }

}

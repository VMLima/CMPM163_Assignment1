using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Controller : MonoBehaviour {

    public float mouseSpeed;

    private float mouseX;
    private float mouseY;
    private Camera cam;

    void Start() {
        cam = GameObject.FindGameObjectWithTag("MainCamera").GetComponent<Camera>();
        Cursor.lockState = CursorLockMode.Locked;
        Cursor.visible = false;
    }

    void Update() {

        mouseX += Input.GetAxis("Mouse X") * mouseSpeed;
        mouseY += Input.GetAxis("Mouse Y") * mouseSpeed;

        cam.transform.eulerAngles = new Vector3(Mathf.Clamp(-mouseY, -90, 90), mouseX + 180, 0);
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeRotation : MonoBehaviour {

    public float speed;
    public bool cube;

    void Update() {
        if (cube) transform.Rotate(speed * 10 * Time.deltaTime, -speed  * 10 * Time.deltaTime, speed * 10 * Time.deltaTime);
        else transform.Rotate(0, -speed * 10 * Time.deltaTime, 0);
    }
}

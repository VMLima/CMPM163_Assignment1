using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ImageUserInput : MonoBehaviour {

    public List<Texture> mondego;

    private float blurVal = 0;
    private float mixVal = 0;
    private float ludVal = 0;

    private Renderer rend;

    // Start is called before the first frame update
    void Start() {
        rend = GetComponent<Renderer>();
        rend.material.shader = Shader.Find("MyCustom/ImageProcessing");

        //mondego = new List<Texture>();
    }

    // Update is called once per frame
    void Update() {

        // Change which texture is being used
        if (Input.GetKeyDown(KeyCode.Alpha1) || Input.GetKeyDown(KeyCode.Keypad1)) {
            rend.material.SetTexture("_MainTex", mondego[0]);
        } else if (Input.GetKeyDown(KeyCode.Alpha2) || Input.GetKeyDown(KeyCode.Keypad2)) {
            rend.material.SetTexture("_MainTex", mondego[1]);
        } else if (Input.GetKeyDown(KeyCode.Alpha3) || Input.GetKeyDown(KeyCode.Keypad3)) {
            rend.material.SetTexture("_MainTex", mondego[2]);
        } else if (Input.GetKeyDown(KeyCode.Alpha4) || Input.GetKeyDown(KeyCode.Keypad4)) {
            rend.material.SetTexture("_MainTex", mondego[3]);
        }

        // Update the blur value by holding Q and pressing the up and down arrows
        if (Input.GetKey(KeyCode.Q)) {
            if (Input.GetKey(KeyCode.UpArrow)) {
                blurVal += 0.5f;
            }
            if (Input.GetKey(KeyCode.DownArrow)) {
                blurVal -= 0.5f;
            }

            blurVal = Mathf.Clamp(blurVal, 0f, 30f);

            rend.material.SetFloat("_BlurSteps", blurVal);
        }

        // Update the mix value by holding W and pressing the up and down arrows
        if (Input.GetKey(KeyCode.W)) {
            if (Input.GetKey(KeyCode.UpArrow)) {
                mixVal += 0.1f;
            }
            if (Input.GetKey(KeyCode.DownArrow)) {
                mixVal -= 0.1f;
            }

            //mixVal = Mathf.Clamp(mixVal, 0f, 30f);

            rend.material.SetFloat("_Mix", mixVal);
        }

        // Update the distance the pixels check by holding E and pressing the up and down arrows
        if (Input.GetKey(KeyCode.E)) {
            if (Input.GetKey(KeyCode.UpArrow)) {
                ludVal += 0.1f;
            }
            if (Input.GetKey(KeyCode.DownArrow)) {
                ludVal -= 0.1f;
            }

            //ludVal = Mathf.Clamp(ludVal, 0f, 30f);

            rend.material.SetFloat("_LookUpDistance", ludVal);
        }

    }
}

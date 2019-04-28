using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeshAnimator : MonoBehaviour {

    public MapGenerator mapGen;

    // Start is called before the first frame update
    void Start() {
        
    }

    // Update is called once per frame
    void Update() {
        mapGen.offset.x += Time.deltaTime / 2.5f;
        mapGen.GenerateMap();

    }
}

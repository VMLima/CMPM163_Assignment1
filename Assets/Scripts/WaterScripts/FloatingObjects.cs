using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FloatingObjects : MonoBehaviour {

    public int offset;

    public MeshFilter mf;
    public MapGenerator mg;

    private Vector3 pos;
    private Vector3 lookPosX;
    private Vector3 lookPosZ;

    void Start() {
        //Mesh mesh = GetComponent<MeshFilter>().mesh;
        //Bounds bounds = mesh.bounds;
        //Debug.Log(name + " " + bounds);
    }

    void Update() {
        int vertCount = 0;
        if (mf.sharedMesh.vertexCount % 2 == 0) {
            vertCount = (mf.sharedMesh.vertexCount / 2) + mg.mapWidth / 2;
        } else if (mf.sharedMesh.vertexCount % 2 == 1) {
            vertCount = (mf.sharedMesh.vertexCount / 2);
        }

        pos = mf.sharedMesh.vertices[vertCount + offset];
        pos = mf.transform.TransformPoint(pos);
        transform.position = new Vector3(pos.x, pos.y, pos.z); // find an offset for y so objects arent always at the very top of the water or sunken in

        // Used to get the object to rotate according to the point adead of them
        // creates a rocking effect boats on the water naturally have
        lookPosX = mf.sharedMesh.vertices[vertCount + offset + 1];
        lookPosX = mf.transform.TransformPoint(lookPosX);

        transform.LookAt(lookPosX);

        //lookPosZ = mf.sharedMesh.vertices[vertCount + offset + mg.mapWidth];
        //lookPosZ = mf.transform.TransformPoint(lookPosZ);

        //transform.LookAt(lookPosZ);

        // Debug.DrawRay(transform.right, transform.right * 50, Color.red);
    }
}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
[CustomEditor(typeof(SaveMesh))]
public class SaveGenerator : Editor {

    public override void OnInspectorGUI() {
        //base.OnInspectorGUI();

        SaveMesh saveMesh = (SaveMesh)target;

        DrawDefaultInspector();

        if (GUILayout.Button("Save")) {
            saveMesh.SavedMesh();
        }
    }

}

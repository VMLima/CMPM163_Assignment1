using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SaveMesh : MonoBehaviour {

    public List<SavedMesh> saveMeshObjects;
    public MapGenerator mapGen;

    void Start() {
        saveMeshObjects = new List<SavedMesh>();
    }

    public void SavedMesh() {
        saveMeshObjects.Add(new SavedMesh(mapGen.mapWidth, mapGen.mapHeight, mapGen.seed, 
                                          mapGen.noiseScale, mapGen.octaves, mapGen.persistence, 
                                          mapGen.lacunarity, mapGen.offset, mapGen.meshHeightMultiplier, 
                                          mapGen.meshHeightCurve, mapGen.autoUpdate, mapGen.regions));
    }
}

[System.Serializable]
public class SavedMesh {
    public string name;
    public int _mapWidth;
    public int _mapHeight;
    public float _noiseScale;

    public int _octaves;
    public float _persistence;
    public float _lacunarity;

    public int _seed;
    public Vector2 _offset;

    public float _meshHeightMultiplier;
    public AnimationCurve _meshHeightCurve;

    public bool _autoUpdate;

    public TerrainType[] _regions;

    public SavedMesh(int mapWidth, int mapHeight, int seed, 
                     float noiseScale, int octaves, float persistence, 
                     float lacunarity, Vector2 offset, float multiplier, 
                     AnimationCurve curve, bool update, TerrainType[] regions) {

        _mapWidth = mapWidth;
        _mapHeight = mapHeight;
        _noiseScale = noiseScale;
        _octaves = octaves;
        _persistence = persistence;
        _lacunarity = lacunarity;
        _seed = seed;
        _offset = offset;
        _meshHeightMultiplier = multiplier;
        _meshHeightCurve = curve;
        _autoUpdate = update;
        _regions = regions;
    }
}

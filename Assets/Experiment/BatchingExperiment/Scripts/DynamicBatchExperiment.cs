using UnityEngine;

public class DynamicBatchExperiment : MonoBehaviour
{
    public GameObject pref;
    public int instances = 5000;
    public float radius = 50f;

    void Start()
    {
        Debug.Log(pref.GetComponent<MeshFilter>().sharedMesh.vertices.Length);
        Debug.Log(pref.GetComponent<MeshFilter>().sharedMesh.GetIndices(0).Length);
        for(int i = 0; i < instances; i++)
        {
            Transform t = Instantiate(pref.transform);
            t.localPosition = new Vector3(i % 70 - 35, 0.0f, Mathf.Floor(i / 70) - 35) * 2.0f;
            t.SetParent(transform);
        }
    }
}
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CamMove : MonoBehaviour
{
    [SerializeField]
    float r;
    [SerializeField]
    float s;
    void Start()
    {
        
    }

    void Update()
    {
        float t = Time.realtimeSinceStartup * s;
        this.transform.position = new Vector3(r * Mathf.Sin(t), 0.0f, r * Mathf.Cos(t));
        this.transform.LookAt(Vector3.zero);
    }
}

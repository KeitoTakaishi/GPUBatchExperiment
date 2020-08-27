using UnityEngine;

[ExecuteInEditMode]
public class InstanceColor : MonoBehaviour
{
    [SerializeField]
    Color color;

    Renderer renderer;
    MaterialPropertyBlock props;

    static readonly int id = Shader.PropertyToID("_Color");

    void Start()
    {
        color = Random.ColorHSV();
        renderer = GetComponent<Renderer>();
        props = new MaterialPropertyBlock();
    }

    void Update()
    {
        props.SetColor(id, color);
        renderer.SetPropertyBlock(props);
    }
}
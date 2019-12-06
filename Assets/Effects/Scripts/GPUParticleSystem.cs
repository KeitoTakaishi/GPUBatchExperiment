using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;


public class GPUParticleSystem : MonoBehaviour
{
    struct Parameters
    {
        Vector3 pos;

        public Parameters(Vector3 p)
        {
            pos = p;
        }
    };

    #region ComputeShader
    [SerializeField] ComputeShader cs;
    [SerializeField] int instancingCount; //BLOCK_SIZEの倍数
    const int BLOCK_SIZE = 64;
    ComputeBuffer parameterBuffer;
    int kernel;
    int threadGroupSize;
    #endregion

    #region instancingParams
    ComputeBuffer argsBuffer;
    private uint[] args = new uint[5];
    [SerializeField] Mesh srcMesh;
    [SerializeField] Material instancingMat;
    #endregion


    void Start()
    {
        InitInstancingParameter();
        //CreateComputeBuffer();
        //kernel = cs.FindKernel("Init");

    }

    void Update()
    {
        Graphics.DrawMeshInstancedIndirect(srcMesh, 0, instancingMat, new Bounds(Vector3.zero, Vector3.one * 32.0f), argsBuffer);
    }
    //---------------------------------
    //Instancing
    private void InitInstancingParameter()
    {
        argsBuffer = new ComputeBuffer(1, args.Length * sizeof(uint), ComputeBufferType.IndirectArguments);
        args[0] = srcMesh.GetIndexCount(0);
        args[1] = (uint)instancingCount;
        args[2] = srcMesh.GetIndexStart(0);
        args[3] = srcMesh.GetBaseVertex(0);
        args[4] = 0;
        argsBuffer.SetData(args);
    }

    //---------------------------------
    void CreateComputeBuffer()
    {
        parameterBuffer = new ComputeBuffer(instancingCount, Marshal.SizeOf(typeof(Parameters)));
    }
    //---------------------------------

}

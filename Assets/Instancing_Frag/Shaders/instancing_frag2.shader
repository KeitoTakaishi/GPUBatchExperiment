Shader "Unlit/instancing_frag2"
{
    Properties
    {
		[HDR]
		_Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
    }
    SubShader
    {
        Pass
        {
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_cimpile_instancing
			#pragma target 4.5
			#include "unityCG.cginc"
			

#if SHADER_TARGET >= 45
	StructuredBuffer<float4> positionBuffer;
#endif

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			half4 _Color;

			v2f vert(appdata v)
			{
#if SHADER_TARGET >= 45
				float4 data = positionBuffer[SV_InstanceID];
#else
				float4 data = 0;
#endif
				v2f o;
				float3 localPosition = v.vertex.xyz * data.w;
				float3 worldPosition = data.xyz + localPosition;
				o.vertex = mul(UNITY_MATRIX_VP, float4(worldPosition, 1.0f));

				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				return _Color;
			}
            ENDCG
        }
    }
}

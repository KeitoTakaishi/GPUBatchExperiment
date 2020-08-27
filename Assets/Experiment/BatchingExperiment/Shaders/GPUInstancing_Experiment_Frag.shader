Shader "Custom/GPUInstancing_Experiment_Frag"
{
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		Pass{
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma multi_compile_instancing
		#pragma vertex  vert
		#pragma fragment frag

		#include "UnityCG.cginc"
		#include "UnityInstancing.cginc"

		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_DEFINE_INSTANCED_PROP(float4, _Color)//Color
		UNITY_INSTANCING_BUFFER_END(Props)
		struct appdata
		{
			float4 vertex : POSITION;
			UNITY_VERTEX_INPUT_INSTANCE_ID//move Vertex
		};

		struct v2f
		{
			float4 vertex : POSITION;
			UNITY_VERTEX_INPUT_INSTANCE_ID//Color
		};

		v2f vert(appdata v)
		{
			v2f o;

			UNITY_SETUP_INSTANCE_ID(v);//Color
			UNITY_TRANSFER_INSTANCE_ID(v, o);// Color

			o.vertex = UnityObjectToClipPos(v.vertex);
			return o;
		}

		fixed4 frag(v2f i) : SV_Target
		{

			fixed4 c = fixed4(1.0.xxxx);
			
			UNITY_SETUP_INSTANCE_ID(i); // Color
			return UNITY_ACCESS_INSTANCED_PROP(Props, _Color) * c;
		}
		ENDCG
		}
	}
}

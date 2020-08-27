Shader "Unlit/DynamicBatching_180Vert"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
            };

            struct v2f
            {
				float2 uv : TEXCOORD0;
				float2 uv1 : TEXCOORD1;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
				float3 normal : TEXCOORD2;
				float4 tangent : TEXCOORD3;

            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
				float4 _v = v.vertex;
				float3 _n = v.normal;
				float4 _t = v.tangent;
				float4 _t0 = v.texcoord;
				float4 _t1 = v.texcoord1;

                o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = normalize(_n);
				o.tangent = _t;
				o.uv = TRANSFORM_TEX(_t0, _MainTex);
				o.uv1 = TRANSFORM_TEX(_t1, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}

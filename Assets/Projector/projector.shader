Shader "Projector"
{
	Properties{
		_ProjTex ("ProjTex", 2D) = "black" {}
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 100 Cull Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 projPos : TEXCOORD1;
				float4 vertex : SV_POSITION;
			};

			sampler2D _ProjTex;
            uniform float4x4 proj_vp_matrix;
            uniform float   test;

			v2f vert(appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				float4 worldPos = mul(unity_ObjectToWorld, v.vertex);
                // o.projPos = mul(proj_vp_matrix, worldPos);
                o.projPos = ComputeScreenPos(mul(proj_vp_matrix, worldPos));
				  // プラットフォームの違いを吸収
    			// o.projPos.y *= _ProjectionParams.x;
				return o;
			}

			half4 frag(v2f i) : SV_Target
			{
				fixed4 col = half4(i.uv,0,1);
				// 0～1に変換
    			// half2 projUv = i.projPos.xy / i.projPos.z * 0.5 + 0.5;
				fixed4 proj = tex2Dproj(_ProjTex, i.projPos);

				return lerp(col, proj, proj.a);
			}
			ENDCG
		}
	}
}

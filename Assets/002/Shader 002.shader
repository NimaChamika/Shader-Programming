Shader "Unlit/Shader 002"
{
    Properties
    {
        _LogoTex ("Logo Texture", 2D) = "white" {}
		_LightSweepTex ("Light Sweep Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
		LOD 100

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
        

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv1 : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
            };

            struct v2f
            {
                float2 uv1 : TEXCOORD0;
				float2 uv2 : TEXCOORD1;
                float4 vertex : SV_POSITION;
            };

            sampler2D _LogoTex;
            float4 _LogoTex_ST;

			sampler2D _LightSweepTex; 
			float4 _LightSweepTex_ST;

			fixed _Factor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv1 = TRANSFORM_TEX(v.uv1, _LogoTex);
				o.uv2 = TRANSFORM_TEX(v.uv2, _LightSweepTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 logoCol = tex2D(_LogoTex, i.uv1);
				fixed4 lightSweepCol = tex2D(_LightSweepTex, i.uv2);

				fixed4 col = logoCol * (1-lightSweepCol.a) + lightSweepCol * lightSweepCol.a;
				col *= logoCol.a;

				return col;
            }
            ENDCG
        }
    }
}

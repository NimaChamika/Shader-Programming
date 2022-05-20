Shader "Unlit/Shader 001"
{
    Properties
    {
        _MainTex1 ("Texture", 2D) = "white" {}
		_MainTex2 ("Texture", 2D) = "white" {}
		_Factor("Factor",Range(0,1)) = 0
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

            sampler2D _MainTex1;
            float4 _MainTex1_ST;

			sampler2D _MainTex2; 
			float4 _MainTex2_ST;

			fixed _Factor;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv1 = TRANSFORM_TEX(v.uv1, _MainTex1);
				o.uv2 = TRANSFORM_TEX(v.uv2, _MainTex2);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col1 = tex2D(_MainTex1, i.uv1);
				fixed4 col2 = tex2D(_MainTex2, i.uv1);

				fixed4 col = col2 * _Factor + col1 * (1-_Factor);
				return col;
            }
            ENDCG
        }
    }
}

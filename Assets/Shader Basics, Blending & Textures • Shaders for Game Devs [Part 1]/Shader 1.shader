Shader "Unlit/Shader 1"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Value ("value", float) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            float _Value;
            
            // Unity handles this bit automatliclly passing the vertex data to the mesh data struct
            struct appdata      // per-vertex mesh data
            {
                float4 vertex : POSITION;       // vertex position
                float3 normals : NORMAL;
                float4 tangent : TANGENT;
                float4 color : COLOR;
                float2 uv : TEXCOORD0;          // uv0 coordinates
                float2 uv1 : TEXCOORD1;         // uv0 coordinates
            };

            // struct containing data passed from the vertex shader to the fragment shader
            struct v2f  // and are called interpolators too
            {
                // clip space position
                float4 vertex : SV_POSITION;

                // this is not uv
                // this can be any amount of data you wanna pass with the struct
                // float2 uv : TEXCOORD0;
            };


            // actual vertex shader
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);          // transform local space into clip space
                return o;
            }


            // float: 32 bits
            // half: 16 bits
            // fixed: less than 16
            // MOstly use floats but halfs are faster for mobiles or something

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                // fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                // UNITY_APPLY_FOG(i.fogCoord, col);
                return float4(1.0, 0.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
}

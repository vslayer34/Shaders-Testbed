// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ShaderDev/BarBone"
{
    Properties
    {
        // _color: variable name
        // "Main Color": Name in Unity inspector
        // Color: Data type of the variable
        // (1, 1, 1, 1): variable default value (red, green, blue, alpha)
        _color ("Main Color", Color) = (1, 1, 1, 1)
    }

    // Hardware specific shader
    SubShader
    {
        // different pass for the shader
        pass
        {
            // writing in cgi shader language
            CGPROGRAM
            // #pragma<compiler directive> <shader command> <argument/function name>
            #pragma vertex vert
            #pragma fragment frag

            // let the shader know that the _color variable is global
            // and tell the _color would accicable for all the function inside this code
            uniform half4 _color;

            // input for the vertex shader
            struct vertexInput
            {
                float4 vertex : POSITION;
            };


            // output of vertex shader and input for fragment shader
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
            };

            vertexOutput vert(vertexInput v)
            {
                vertexOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            // it take vertexOutput as a parameter
            // and return color which consist of 4 channels of type half
            // : COLOR is a hint that the 4 channels are for color not position for example

            // it takes the color from the property and color the mesh with it
            half4 frag(vertexOutput i) : Color
            {
                return _color;
            }

            ENDCG
        }
    }
}
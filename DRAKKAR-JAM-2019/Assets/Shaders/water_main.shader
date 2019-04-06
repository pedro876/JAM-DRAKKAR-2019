// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33726,y:32737,varname:node_3138,prsc:2|emission-7756-RGB;n:type:ShaderForge.SFN_Tex2d,id:7756,x:33443,y:32919,ptovrint:False,ptlb:Texture,ptin:_Texture,varname:node_7756,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:6da572218120d0049b599e7dddfc278e,ntxv:3,isnm:False|UVIN-827-OUT;n:type:ShaderForge.SFN_TexCoord,id:1738,x:32730,y:32881,varname:node_1738,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_RemapRange,id:9712,x:32936,y:32851,varname:node_9712,prsc:2,frmn:0,frmx:1,tomn:-1,tomx:1|IN-1738-UVOUT;n:type:ShaderForge.SFN_Time,id:6080,x:32711,y:33051,varname:node_6080,prsc:2;n:type:ShaderForge.SFN_Multiply,id:6127,x:33213,y:33079,varname:node_6127,prsc:2|A-6134-OUT,B-1252-OUT;n:type:ShaderForge.SFN_Multiply,id:6134,x:32936,y:33065,varname:node_6134,prsc:2|A-6080-TSL,B-1252-OUT;n:type:ShaderForge.SFN_ComponentMask,id:1252,x:33002,y:33252,varname:node_1252,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-3247-XYZ;n:type:ShaderForge.SFN_Add,id:827,x:33182,y:32874,varname:node_827,prsc:2|A-9712-OUT,B-6134-OUT;n:type:ShaderForge.SFN_Vector4Property,id:3247,x:32814,y:33327,ptovrint:False,ptlb:DirectionXY,ptin:_DirectionXY,varname:node_3247,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1,v2:-1,v3:0,v4:0;proporder:7756-3247;pass:END;sub:END;*/

Shader "Shader Forge/water_main" {
    Properties {
        _Texture ("Texture", 2D) = "bump" {}
        _DirectionXY ("DirectionXY", Vector) = (1,-1,0,0)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _Texture; uniform float4 _Texture_ST;
            uniform float4 _DirectionXY;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float4 node_6080 = _Time;
                float2 node_1252 = _DirectionXY.rgb.rg;
                float2 node_6134 = (node_6080.r*node_1252);
                float2 node_827 = ((i.uv0*2.0+-1.0)+node_6134);
                float4 _Texture_var = tex2D(_Texture,TRANSFORM_TEX(node_827, _Texture));
                float3 emissive = _Texture_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}

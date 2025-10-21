Shader "Particles/Priority Additive (Soft)" {
	Properties {
		_MainTex ("Particle Texture", 2D) = "white" {}
		_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
			Blend One OneMinusSrcColor, One OneMinusSrcColor
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 8520
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 prev_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
					  prev_2 = tmpvar_3;
					  prev_2.xyz = (prev_2.xyz * prev_2.w);
					  tmpvar_1 = prev_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 prev_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
					  prev_2 = tmpvar_3;
					  prev_2.xyz = (prev_2.xyz * prev_2.w);
					  tmpvar_1 = prev_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1.w = 1.0;
					  tmpvar_1.xyz = _glesVertex.xyz;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 prev_2;
					  lowp vec4 tmpvar_3;
					  tmpvar_3 = (xlv_COLOR * texture2D (_MainTex, xlv_TEXCOORD0));
					  prev_2 = tmpvar_3;
					  prev_2.xyz = (prev_2.xyz * prev_2.w);
					  tmpvar_1 = prev_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_1.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_2.xyw = o_5.xyw;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1.xyz;
					  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
					  gl_Position = tmpvar_3;
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2.xyz = xlv_COLOR.xyz;
					  mediump vec4 prev_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
					  highp float z_5;
					  z_5 = tmpvar_4.x;
					  highp float tmpvar_6;
					  tmpvar_6 = clamp ((_InvFade * (
					    (1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w)))
					   - xlv_TEXCOORD1.z)), 0.0, 1.0);
					  tmpvar_2.w = (xlv_COLOR.w * tmpvar_6);
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_2 * texture2D (_MainTex, xlv_TEXCOORD0));
					  prev_3 = tmpvar_7;
					  prev_3.xyz = (prev_3.xyz * prev_3.w);
					  tmpvar_1 = prev_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_1.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_2.xyw = o_5.xyw;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1.xyz;
					  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
					  gl_Position = tmpvar_3;
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2.xyz = xlv_COLOR.xyz;
					  mediump vec4 prev_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
					  highp float z_5;
					  z_5 = tmpvar_4.x;
					  highp float tmpvar_6;
					  tmpvar_6 = clamp ((_InvFade * (
					    (1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w)))
					   - xlv_TEXCOORD1.z)), 0.0, 1.0);
					  tmpvar_2.w = (xlv_COLOR.w * tmpvar_6);
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_2 * texture2D (_MainTex, xlv_TEXCOORD0));
					  prev_3 = tmpvar_7;
					  prev_3.xyz = (prev_3.xyz * prev_3.w);
					  tmpvar_1 = prev_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _ProjectionParams;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  highp vec4 tmpvar_1;
					  tmpvar_1 = _glesVertex;
					  highp vec4 tmpvar_2;
					  highp vec4 tmpvar_3;
					  highp vec4 tmpvar_4;
					  tmpvar_4.w = 1.0;
					  tmpvar_4.xyz = tmpvar_1.xyz;
					  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
					  highp vec4 o_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6 = (tmpvar_3 * 0.5);
					  highp vec2 tmpvar_7;
					  tmpvar_7.x = tmpvar_6.x;
					  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
					  o_5.xy = (tmpvar_7 + tmpvar_6.w);
					  o_5.zw = tmpvar_3.zw;
					  tmpvar_2.xyw = o_5.xyw;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1.xyz;
					  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
					  gl_Position = tmpvar_3;
					  xlv_COLOR = _glesColor;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_2;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _ZBufferParams;
					uniform sampler2D _MainTex;
					uniform sampler2D _CameraDepthTexture;
					uniform highp float _InvFade;
					varying lowp vec4 xlv_COLOR;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2.xyz = xlv_COLOR.xyz;
					  mediump vec4 prev_3;
					  lowp vec4 tmpvar_4;
					  tmpvar_4 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
					  highp float z_5;
					  z_5 = tmpvar_4.x;
					  highp float tmpvar_6;
					  tmpvar_6 = clamp ((_InvFade * (
					    (1.0/(((_ZBufferParams.z * z_5) + _ZBufferParams.w)))
					   - xlv_TEXCOORD1.z)), 0.0, 1.0);
					  tmpvar_2.w = (xlv_COLOR.w * tmpvar_6);
					  lowp vec4 tmpvar_7;
					  tmpvar_7 = (tmpvar_2 * texture2D (_MainTex, xlv_TEXCOORD0));
					  prev_3 = tmpvar_7;
					  prev_3.xyz = (prev_3.xyz * prev_3.w);
					  tmpvar_1 = prev_3;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SOFTPARTICLES_ON" }
					"!!GLES"
				}
			}
		}
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
			Blend One OneMinusSrcColor, One OneMinusSrcColor
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			Fog {
				Mode Off
			}
			GpuProgramID 119276
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
					  xlv_TEXCOORD0 = (tmpvar_4 + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (tmpvar_4 + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  col_1.xyz = (col_1 * col_1.w).xyz;
					  col_1.w = col_1.w;
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
					  xlv_TEXCOORD0 = (tmpvar_4 + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (tmpvar_4 + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  col_1.xyz = (col_1 * col_1.w).xyz;
					  col_1.w = col_1.w;
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  highp vec2 tmpvar_4;
					  tmpvar_4 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
					  xlv_TEXCOORD0 = (tmpvar_4 + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (tmpvar_4 + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  col_1.xyz = (col_1 * col_1.w).xyz;
					  col_1.w = col_1.w;
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = tmpvar_1;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
					  lowp vec4 tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_4 = tmpvar_5;
					  lowp float tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (((
					    sqrt(dot (tmpvar_3, tmpvar_3))
					   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
					  tmpvar_6 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1;
					  xlv_COLOR0 = tmpvar_4;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
					  xlv_TEXCOORD0 = (tmpvar_9 + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (tmpvar_9 + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = tmpvar_6;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 col_1;
					  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  col_1.xyz = (col_1 * col_1.w).xyz;
					  col_1.w = col_1.w;
					  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD2));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = tmpvar_1;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
					  lowp vec4 tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_4 = tmpvar_5;
					  lowp float tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (((
					    sqrt(dot (tmpvar_3, tmpvar_3))
					   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
					  tmpvar_6 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1;
					  xlv_COLOR0 = tmpvar_4;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
					  xlv_TEXCOORD0 = (tmpvar_9 + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (tmpvar_9 + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = tmpvar_6;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 col_1;
					  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  col_1.xyz = (col_1 * col_1.w).xyz;
					  col_1.w = col_1.w;
					  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD2));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying highp vec2 xlv_TEXCOORD1;
					varying lowp float xlv_TEXCOORD2;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = tmpvar_1;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
					  lowp vec4 tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_4 = tmpvar_5;
					  lowp float tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (((
					    sqrt(dot (tmpvar_3, tmpvar_3))
					   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
					  tmpvar_6 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1;
					  xlv_COLOR0 = tmpvar_4;
					  highp vec2 tmpvar_9;
					  tmpvar_9 = (_glesMultiTexCoord0.xy * _MainTex_ST.xy);
					  xlv_TEXCOORD0 = (tmpvar_9 + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = (tmpvar_9 + _MainTex_ST.zw);
					  xlv_TEXCOORD2 = tmpvar_6;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD2;
					void main ()
					{
					  lowp vec4 col_1;
					  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR0);
					  col_1.xyz = (col_1 * col_1.w).xyz;
					  col_1.w = col_1.w;
					  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD2));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
			}
		}
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
			Blend One OneMinusSrcColor, One OneMinusSrcColor
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			Fog {
				Mode Off
			}
			GpuProgramID 150867
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.xyz = (tmpvar_2 * tmpvar_2.w).xyz;
					  col_1.w = tmpvar_2.w;
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.xyz = (tmpvar_2 * tmpvar_2.w).xyz;
					  col_1.w = tmpvar_2.w;
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 tmpvar_2;
					  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_1 = tmpvar_2;
					  highp vec4 tmpvar_3;
					  tmpvar_3.w = 1.0;
					  tmpvar_3.xyz = _glesVertex.xyz;
					  xlv_COLOR0 = tmpvar_1;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.xyz = (tmpvar_2 * tmpvar_2.w).xyz;
					  col_1.w = tmpvar_2.w;
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = tmpvar_1;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
					  lowp vec4 tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_4 = tmpvar_5;
					  lowp float tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (((
					    sqrt(dot (tmpvar_3, tmpvar_3))
					   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
					  tmpvar_6 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1;
					  xlv_COLOR0 = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_6;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.xyz = (tmpvar_2 * tmpvar_2.w).xyz;
					  col_1.w = tmpvar_2.w;
					  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = tmpvar_1;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
					  lowp vec4 tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_4 = tmpvar_5;
					  lowp float tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (((
					    sqrt(dot (tmpvar_3, tmpvar_3))
					   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
					  tmpvar_6 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1;
					  xlv_COLOR0 = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_6;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.xyz = (tmpvar_2 * tmpvar_2.w).xyz;
					  col_1.w = tmpvar_2.w;
					  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_MatrixV;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _MainTex_ST;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD1;
					void main ()
					{
					  highp vec3 tmpvar_1;
					  tmpvar_1 = _glesVertex.xyz;
					  highp vec4 tmpvar_2;
					  tmpvar_2.w = 1.0;
					  tmpvar_2.xyz = tmpvar_1;
					  highp vec3 tmpvar_3;
					  tmpvar_3 = ((unity_MatrixV * unity_ObjectToWorld) * tmpvar_2).xyz;
					  lowp vec4 tmpvar_4;
					  mediump vec4 tmpvar_5;
					  tmpvar_5 = clamp (_glesColor, 0.0, 1.0);
					  tmpvar_4 = tmpvar_5;
					  lowp float tmpvar_6;
					  highp float tmpvar_7;
					  tmpvar_7 = clamp (((
					    sqrt(dot (tmpvar_3, tmpvar_3))
					   * unity_FogParams.z) + unity_FogParams.w), 0.0, 1.0);
					  tmpvar_6 = tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_1;
					  xlv_COLOR0 = tmpvar_4;
					  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
					  xlv_TEXCOORD1 = tmpvar_6;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform lowp vec4 unity_FogColor;
					uniform sampler2D _MainTex;
					varying highp vec2 xlv_TEXCOORD0;
					varying lowp float xlv_TEXCOORD1;
					void main ()
					{
					  lowp vec4 col_1;
					  lowp vec4 tmpvar_2;
					  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
					  col_1.xyz = (tmpvar_2 * tmpvar_2.w).xyz;
					  col_1.w = tmpvar_2.w;
					  col_1.xyz = mix (unity_FogColor.xyz, col_1.xyz, vec3(xlv_TEXCOORD1));
					  gl_FragData[0] = col_1;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES"
				}
			}
		}
	}
}
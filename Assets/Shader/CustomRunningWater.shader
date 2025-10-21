Shader "Custom/RunningWater" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_SpecColor ("Specular Color", Vector) = (0.5,0.5,0.5,1)
		_Shininess ("Shininess", Range(0.01, 1)) = 0.078125
		_Transparency ("Transparency", Range(-0.5, 0.5)) = 0.1
		_MaxWaterSpeed ("max water velocity", Range(-100, 100)) = 5
		_WaveSpeed ("wave velocity", Range(-10, 10)) = 1
		_ReflectColor ("Reflection Color", Vector) = (1,1,1,0.5)
		_Cube ("Reflection Cubemap", Cube) = "" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_SplashTex ("Splash Texture", 2D) = "Black" {}
	}
	SubShader {
		LOD 400
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 34994
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  mediump vec3 normal_17;
					  normal_17 = worldNormal_3;
					  mediump vec3 x1_18;
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
					  x1_18.x = dot (unity_SHBr, tmpvar_19);
					  x1_18.y = dot (unity_SHBg, tmpvar_19);
					  x1_18.z = dot (unity_SHBb, tmpvar_19);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = (x1_18 + (unity_SHC.xyz * (
					    (normal_17.x * normal_17.x)
					   - 
					    (normal_17.y * normal_17.y)
					  )));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  mediump vec3 normal_17;
					  normal_17 = worldNormal_3;
					  mediump vec3 x1_18;
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
					  x1_18.x = dot (unity_SHBr, tmpvar_19);
					  x1_18.y = dot (unity_SHBg, tmpvar_19);
					  x1_18.z = dot (unity_SHBb, tmpvar_19);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = (x1_18 + (unity_SHC.xyz * (
					    (normal_17.x * normal_17.x)
					   - 
					    (normal_17.y * normal_17.y)
					  )));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  mediump vec3 normal_17;
					  normal_17 = worldNormal_3;
					  mediump vec3 x1_18;
					  mediump vec4 tmpvar_19;
					  tmpvar_19 = (normal_17.xyzz * normal_17.yzzx);
					  x1_18.x = dot (unity_SHBr, tmpvar_19);
					  x1_18.y = dot (unity_SHBg, tmpvar_19);
					  x1_18.z = dot (unity_SHBb, tmpvar_19);
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = (x1_18 + (unity_SHC.xyz * (
					    (normal_17.x * normal_17.x)
					   - 
					    (normal_17.y * normal_17.y)
					  )));
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  mediump vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = _glesVertex.w;
					  tmpvar_6.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_6.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_3;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (lengthSq_26, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_26 = tmpvar_30;
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(tmpvar_30)));
					  ndotl_25 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = (tmpvar_31 * (1.0/((1.0 + 
					    (tmpvar_30 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_32.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_32.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_32.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_32.w));
					  tmpvar_5 = col_24;
					  mediump vec3 normal_33;
					  normal_33 = worldNormal_3;
					  mediump vec3 ambient_34;
					  mediump vec3 x1_35;
					  mediump vec4 tmpvar_36;
					  tmpvar_36 = (normal_33.xyzz * normal_33.yzzx);
					  x1_35.x = dot (unity_SHBr, tmpvar_36);
					  x1_35.y = dot (unity_SHBg, tmpvar_36);
					  x1_35.z = dot (unity_SHBb, tmpvar_36);
					  ambient_34 = ((tmpvar_5 * (
					    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_35 + (unity_SHC.xyz * 
					    ((normal_33.x * normal_33.x) - (normal_33.y * normal_33.y))
					  )));
					  tmpvar_5 = ambient_34;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = ambient_34;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  mediump vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = _glesVertex.w;
					  tmpvar_6.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_6.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_3;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (lengthSq_26, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_26 = tmpvar_30;
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(tmpvar_30)));
					  ndotl_25 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = (tmpvar_31 * (1.0/((1.0 + 
					    (tmpvar_30 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_32.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_32.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_32.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_32.w));
					  tmpvar_5 = col_24;
					  mediump vec3 normal_33;
					  normal_33 = worldNormal_3;
					  mediump vec3 ambient_34;
					  mediump vec3 x1_35;
					  mediump vec4 tmpvar_36;
					  tmpvar_36 = (normal_33.xyzz * normal_33.yzzx);
					  x1_35.x = dot (unity_SHBr, tmpvar_36);
					  x1_35.y = dot (unity_SHBg, tmpvar_36);
					  x1_35.z = dot (unity_SHBb, tmpvar_36);
					  ambient_34 = ((tmpvar_5 * (
					    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_35 + (unity_SHC.xyz * 
					    ((normal_33.x * normal_33.x) - (normal_33.y * normal_33.y))
					  )));
					  tmpvar_5 = ambient_34;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = ambient_34;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  mediump vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = _glesVertex.w;
					  tmpvar_6.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_6.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  highp vec3 lightColor0_18;
					  lightColor0_18 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_19;
					  lightColor1_19 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_20;
					  lightColor2_20 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_21;
					  lightColor3_21 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_22;
					  lightAttenSq_22 = unity_4LightAtten0;
					  highp vec3 normal_23;
					  normal_23 = worldNormal_3;
					  highp vec3 col_24;
					  highp vec4 ndotl_25;
					  highp vec4 lengthSq_26;
					  highp vec4 tmpvar_27;
					  tmpvar_27 = (unity_4LightPosX0 - tmpvar_8.x);
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosY0 - tmpvar_8.y);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosZ0 - tmpvar_8.z);
					  lengthSq_26 = (tmpvar_27 * tmpvar_27);
					  lengthSq_26 = (lengthSq_26 + (tmpvar_28 * tmpvar_28));
					  lengthSq_26 = (lengthSq_26 + (tmpvar_29 * tmpvar_29));
					  highp vec4 tmpvar_30;
					  tmpvar_30 = max (lengthSq_26, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_26 = tmpvar_30;
					  ndotl_25 = (tmpvar_27 * normal_23.x);
					  ndotl_25 = (ndotl_25 + (tmpvar_28 * normal_23.y));
					  ndotl_25 = (ndotl_25 + (tmpvar_29 * normal_23.z));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_25 * inversesqrt(tmpvar_30)));
					  ndotl_25 = tmpvar_31;
					  highp vec4 tmpvar_32;
					  tmpvar_32 = (tmpvar_31 * (1.0/((1.0 + 
					    (tmpvar_30 * lightAttenSq_22)
					  ))));
					  col_24 = (lightColor0_18 * tmpvar_32.x);
					  col_24 = (col_24 + (lightColor1_19 * tmpvar_32.y));
					  col_24 = (col_24 + (lightColor2_20 * tmpvar_32.z));
					  col_24 = (col_24 + (lightColor3_21 * tmpvar_32.w));
					  tmpvar_5 = col_24;
					  mediump vec3 normal_33;
					  normal_33 = worldNormal_3;
					  mediump vec3 ambient_34;
					  mediump vec3 x1_35;
					  mediump vec4 tmpvar_36;
					  tmpvar_36 = (normal_33.xyzz * normal_33.yzzx);
					  x1_35.x = dot (unity_SHBr, tmpvar_36);
					  x1_35.y = dot (unity_SHBg, tmpvar_36);
					  x1_35.z = dot (unity_SHBb, tmpvar_36);
					  ambient_34 = ((tmpvar_5 * (
					    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_35 + (unity_SHC.xyz * 
					    ((normal_33.x * normal_33.x) - (normal_33.y * normal_33.y))
					  )));
					  tmpvar_5 = ambient_34;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = ambient_34;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  highp float tmpvar_50;
					  tmpvar_50 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_50));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  highp float tmpvar_50;
					  tmpvar_50 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_50));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  highp float tmpvar_50;
					  tmpvar_50 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_50));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  mediump vec3 normal_18;
					  normal_18 = worldNormal_3;
					  mediump vec3 x1_19;
					  mediump vec4 tmpvar_20;
					  tmpvar_20 = (normal_18.xyzz * normal_18.yzzx);
					  x1_19.x = dot (unity_SHBr, tmpvar_20);
					  x1_19.y = dot (unity_SHBg, tmpvar_20);
					  x1_19.z = dot (unity_SHBb, tmpvar_20);
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = (x1_19 + (unity_SHC.xyz * (
					    (normal_18.x * normal_18.x)
					   - 
					    (normal_18.y * normal_18.y)
					  )));
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  highp float tmpvar_54;
					  tmpvar_54 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_54));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  mediump vec3 normal_18;
					  normal_18 = worldNormal_3;
					  mediump vec3 x1_19;
					  mediump vec4 tmpvar_20;
					  tmpvar_20 = (normal_18.xyzz * normal_18.yzzx);
					  x1_19.x = dot (unity_SHBr, tmpvar_20);
					  x1_19.y = dot (unity_SHBg, tmpvar_20);
					  x1_19.z = dot (unity_SHBb, tmpvar_20);
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = (x1_19 + (unity_SHC.xyz * (
					    (normal_18.x * normal_18.x)
					   - 
					    (normal_18.y * normal_18.y)
					  )));
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  highp float tmpvar_54;
					  tmpvar_54 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_54));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  mediump vec3 normal_18;
					  normal_18 = worldNormal_3;
					  mediump vec3 x1_19;
					  mediump vec4 tmpvar_20;
					  tmpvar_20 = (normal_18.xyzz * normal_18.yzzx);
					  x1_19.x = dot (unity_SHBr, tmpvar_20);
					  x1_19.y = dot (unity_SHBg, tmpvar_20);
					  x1_19.z = dot (unity_SHBb, tmpvar_20);
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = (x1_19 + (unity_SHC.xyz * (
					    (normal_18.x * normal_18.x)
					   - 
					    (normal_18.y * normal_18.y)
					  )));
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  highp float tmpvar_54;
					  tmpvar_54 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_54));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  highp float tmpvar_50;
					  tmpvar_50 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_50));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  highp float tmpvar_50;
					  tmpvar_50 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_50));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_8;
					  tmpvar_8 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_WorldToObject[0].xyz;
					  tmpvar_9[1] = unity_WorldToObject[1].xyz;
					  tmpvar_9[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
					  worldNormal_3 = tmpvar_10;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_12;
					  highp float tmpvar_13;
					  tmpvar_13 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_13;
					  lowp vec3 tmpvar_14;
					  tmpvar_14 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.x;
					  tmpvar_15.y = tmpvar_14.x;
					  tmpvar_15.z = worldNormal_3.x;
					  tmpvar_15.w = tmpvar_8.x;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.y;
					  tmpvar_16.y = tmpvar_14.y;
					  tmpvar_16.z = worldNormal_3.y;
					  tmpvar_16.w = tmpvar_8.y;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.z;
					  tmpvar_17.y = tmpvar_14.z;
					  tmpvar_17.z = worldNormal_3.z;
					  tmpvar_17.w = tmpvar_8.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_15;
					  xlv_TEXCOORD2 = tmpvar_16;
					  xlv_TEXCOORD3 = tmpvar_17;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_41;
					  viewDir_41 = worldViewDir_5;
					  lowp vec4 c_42;
					  lowp vec4 c_43;
					  highp float nh_44;
					  lowp float diff_45;
					  mediump float tmpvar_46;
					  tmpvar_46 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_45 = tmpvar_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_41)
					  )));
					  nh_44 = tmpvar_47;
					  mediump float y_48;
					  y_48 = (tmpvar_17 * 128.0);
					  highp float tmpvar_49;
					  tmpvar_49 = (pow (nh_44, y_48) * tmpvar_18);
					  c_43.xyz = (((c_20.xyz * tmpvar_1) * diff_45) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_49));
					  c_43.w = tmpvar_19;
					  c_42.w = c_43.w;
					  c_42.xyz = c_43.xyz;
					  c_4.w = c_42.w;
					  c_4.xyz = (c_43.xyz + tmpvar_16);
					  highp float tmpvar_50;
					  tmpvar_50 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_50));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  mediump vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = _glesVertex.w;
					  tmpvar_6.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_6.xyz;
					  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
					  worldNormal_3 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_14;
					  lowp vec3 tmpvar_15;
					  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.x;
					  tmpvar_16.y = tmpvar_15.x;
					  tmpvar_16.z = worldNormal_3.x;
					  tmpvar_16.w = tmpvar_9.x;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.y;
					  tmpvar_17.y = tmpvar_15.y;
					  tmpvar_17.z = worldNormal_3.y;
					  tmpvar_17.w = tmpvar_9.y;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.z;
					  tmpvar_18.y = tmpvar_15.z;
					  tmpvar_18.z = worldNormal_3.z;
					  tmpvar_18.w = tmpvar_9.z;
					  highp vec3 lightColor0_19;
					  lightColor0_19 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_20;
					  lightColor1_20 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_21;
					  lightColor2_21 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_22;
					  lightColor3_22 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_23;
					  lightAttenSq_23 = unity_4LightAtten0;
					  highp vec3 normal_24;
					  normal_24 = worldNormal_3;
					  highp vec3 col_25;
					  highp vec4 ndotl_26;
					  highp vec4 lengthSq_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
					  lengthSq_27 = (tmpvar_28 * tmpvar_28);
					  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
					  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_27 = tmpvar_31;
					  ndotl_26 = (tmpvar_28 * normal_24.x);
					  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
					  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
					  highp vec4 tmpvar_32;
					  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
					  ndotl_26 = tmpvar_32;
					  highp vec4 tmpvar_33;
					  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
					    (tmpvar_31 * lightAttenSq_23)
					  ))));
					  col_25 = (lightColor0_19 * tmpvar_33.x);
					  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
					  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
					  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
					  tmpvar_5 = col_25;
					  mediump vec3 normal_34;
					  normal_34 = worldNormal_3;
					  mediump vec3 ambient_35;
					  mediump vec3 x1_36;
					  mediump vec4 tmpvar_37;
					  tmpvar_37 = (normal_34.xyzz * normal_34.yzzx);
					  x1_36.x = dot (unity_SHBr, tmpvar_37);
					  x1_36.y = dot (unity_SHBg, tmpvar_37);
					  x1_36.z = dot (unity_SHBb, tmpvar_37);
					  ambient_35 = ((tmpvar_5 * (
					    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
					    ((normal_34.x * normal_34.x) - (normal_34.y * normal_34.y))
					  )));
					  tmpvar_5 = ambient_35;
					  gl_Position = tmpvar_7;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_16;
					  xlv_TEXCOORD2 = tmpvar_17;
					  xlv_TEXCOORD3 = tmpvar_18;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = ambient_35;
					  xlv_TEXCOORD5 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  highp float tmpvar_54;
					  tmpvar_54 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_54));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  mediump vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = _glesVertex.w;
					  tmpvar_6.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_6.xyz;
					  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
					  worldNormal_3 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_14;
					  lowp vec3 tmpvar_15;
					  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.x;
					  tmpvar_16.y = tmpvar_15.x;
					  tmpvar_16.z = worldNormal_3.x;
					  tmpvar_16.w = tmpvar_9.x;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.y;
					  tmpvar_17.y = tmpvar_15.y;
					  tmpvar_17.z = worldNormal_3.y;
					  tmpvar_17.w = tmpvar_9.y;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.z;
					  tmpvar_18.y = tmpvar_15.z;
					  tmpvar_18.z = worldNormal_3.z;
					  tmpvar_18.w = tmpvar_9.z;
					  highp vec3 lightColor0_19;
					  lightColor0_19 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_20;
					  lightColor1_20 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_21;
					  lightColor2_21 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_22;
					  lightColor3_22 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_23;
					  lightAttenSq_23 = unity_4LightAtten0;
					  highp vec3 normal_24;
					  normal_24 = worldNormal_3;
					  highp vec3 col_25;
					  highp vec4 ndotl_26;
					  highp vec4 lengthSq_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
					  lengthSq_27 = (tmpvar_28 * tmpvar_28);
					  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
					  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_27 = tmpvar_31;
					  ndotl_26 = (tmpvar_28 * normal_24.x);
					  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
					  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
					  highp vec4 tmpvar_32;
					  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
					  ndotl_26 = tmpvar_32;
					  highp vec4 tmpvar_33;
					  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
					    (tmpvar_31 * lightAttenSq_23)
					  ))));
					  col_25 = (lightColor0_19 * tmpvar_33.x);
					  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
					  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
					  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
					  tmpvar_5 = col_25;
					  mediump vec3 normal_34;
					  normal_34 = worldNormal_3;
					  mediump vec3 ambient_35;
					  mediump vec3 x1_36;
					  mediump vec4 tmpvar_37;
					  tmpvar_37 = (normal_34.xyzz * normal_34.yzzx);
					  x1_36.x = dot (unity_SHBr, tmpvar_37);
					  x1_36.y = dot (unity_SHBg, tmpvar_37);
					  x1_36.z = dot (unity_SHBb, tmpvar_37);
					  ambient_35 = ((tmpvar_5 * (
					    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
					    ((normal_34.x * normal_34.x) - (normal_34.y * normal_34.y))
					  )));
					  tmpvar_5 = ambient_35;
					  gl_Position = tmpvar_7;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_16;
					  xlv_TEXCOORD2 = tmpvar_17;
					  xlv_TEXCOORD3 = tmpvar_18;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = ambient_35;
					  xlv_TEXCOORD5 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  highp float tmpvar_54;
					  tmpvar_54 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_54));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" "VERTEXLIGHT_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 unity_4LightPosX0;
					uniform highp vec4 unity_4LightPosY0;
					uniform highp vec4 unity_4LightPosZ0;
					uniform mediump vec4 unity_4LightAtten0;
					uniform mediump vec4 unity_LightColor[8];
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  mediump vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = _glesVertex.w;
					  tmpvar_6.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_7;
					  highp vec4 tmpvar_8;
					  tmpvar_8.w = 1.0;
					  tmpvar_8.xyz = tmpvar_6.xyz;
					  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_9;
					  tmpvar_9 = (unity_ObjectToWorld * tmpvar_6).xyz;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_WorldToObject[0].xyz;
					  tmpvar_10[1] = unity_WorldToObject[1].xyz;
					  tmpvar_10[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
					  worldNormal_3 = tmpvar_11;
					  highp mat3 tmpvar_12;
					  tmpvar_12[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_12[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_12[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((tmpvar_12 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_13;
					  highp float tmpvar_14;
					  tmpvar_14 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_14;
					  lowp vec3 tmpvar_15;
					  tmpvar_15 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.x;
					  tmpvar_16.y = tmpvar_15.x;
					  tmpvar_16.z = worldNormal_3.x;
					  tmpvar_16.w = tmpvar_9.x;
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.y;
					  tmpvar_17.y = tmpvar_15.y;
					  tmpvar_17.z = worldNormal_3.y;
					  tmpvar_17.w = tmpvar_9.y;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.z;
					  tmpvar_18.y = tmpvar_15.z;
					  tmpvar_18.z = worldNormal_3.z;
					  tmpvar_18.w = tmpvar_9.z;
					  highp vec3 lightColor0_19;
					  lightColor0_19 = unity_LightColor[0].xyz;
					  highp vec3 lightColor1_20;
					  lightColor1_20 = unity_LightColor[1].xyz;
					  highp vec3 lightColor2_21;
					  lightColor2_21 = unity_LightColor[2].xyz;
					  highp vec3 lightColor3_22;
					  lightColor3_22 = unity_LightColor[3].xyz;
					  highp vec4 lightAttenSq_23;
					  lightAttenSq_23 = unity_4LightAtten0;
					  highp vec3 normal_24;
					  normal_24 = worldNormal_3;
					  highp vec3 col_25;
					  highp vec4 ndotl_26;
					  highp vec4 lengthSq_27;
					  highp vec4 tmpvar_28;
					  tmpvar_28 = (unity_4LightPosX0 - tmpvar_9.x);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = (unity_4LightPosY0 - tmpvar_9.y);
					  highp vec4 tmpvar_30;
					  tmpvar_30 = (unity_4LightPosZ0 - tmpvar_9.z);
					  lengthSq_27 = (tmpvar_28 * tmpvar_28);
					  lengthSq_27 = (lengthSq_27 + (tmpvar_29 * tmpvar_29));
					  lengthSq_27 = (lengthSq_27 + (tmpvar_30 * tmpvar_30));
					  highp vec4 tmpvar_31;
					  tmpvar_31 = max (lengthSq_27, vec4(1e-06, 1e-06, 1e-06, 1e-06));
					  lengthSq_27 = tmpvar_31;
					  ndotl_26 = (tmpvar_28 * normal_24.x);
					  ndotl_26 = (ndotl_26 + (tmpvar_29 * normal_24.y));
					  ndotl_26 = (ndotl_26 + (tmpvar_30 * normal_24.z));
					  highp vec4 tmpvar_32;
					  tmpvar_32 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_26 * inversesqrt(tmpvar_31)));
					  ndotl_26 = tmpvar_32;
					  highp vec4 tmpvar_33;
					  tmpvar_33 = (tmpvar_32 * (1.0/((1.0 + 
					    (tmpvar_31 * lightAttenSq_23)
					  ))));
					  col_25 = (lightColor0_19 * tmpvar_33.x);
					  col_25 = (col_25 + (lightColor1_20 * tmpvar_33.y));
					  col_25 = (col_25 + (lightColor2_21 * tmpvar_33.z));
					  col_25 = (col_25 + (lightColor3_22 * tmpvar_33.w));
					  tmpvar_5 = col_25;
					  mediump vec3 normal_34;
					  normal_34 = worldNormal_3;
					  mediump vec3 ambient_35;
					  mediump vec3 x1_36;
					  mediump vec4 tmpvar_37;
					  tmpvar_37 = (normal_34.xyzz * normal_34.yzzx);
					  x1_36.x = dot (unity_SHBr, tmpvar_37);
					  x1_36.y = dot (unity_SHBg, tmpvar_37);
					  x1_36.z = dot (unity_SHBb, tmpvar_37);
					  ambient_35 = ((tmpvar_5 * (
					    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
					   + 0.01252288)) + (x1_36 + (unity_SHC.xyz * 
					    ((normal_34.x * normal_34.x) - (normal_34.y * normal_34.y))
					  )));
					  tmpvar_5 = ambient_35;
					  gl_Position = tmpvar_7;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_16;
					  xlv_TEXCOORD2 = tmpvar_17;
					  xlv_TEXCOORD3 = tmpvar_18;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = ambient_35;
					  xlv_TEXCOORD5 = ((tmpvar_7.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying mediump vec3 xlv_TEXCOORD4;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12.x = xlv_TEXCOORD1.w;
					  tmpvar_12.y = xlv_TEXCOORD2.w;
					  tmpvar_12.z = xlv_TEXCOORD3.w;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - tmpvar_12));
					  worldViewDir_5 = tmpvar_14;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1.xyz;
					  tmpvar_10 = xlv_TEXCOORD2.xyz;
					  tmpvar_11 = xlv_TEXCOORD3.xyz;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_8.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_15 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_9, tmpvar_15);
					  tmpvar_34.y = dot (tmpvar_10, tmpvar_15);
					  tmpvar_34.z = dot (tmpvar_11, tmpvar_15);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_34, tmpvar_7)
					   * tmpvar_34)));
					  lowp vec4 tmpvar_36;
					  tmpvar_36 = textureCube (_Cube, tmpvar_35);
					  tmpvar_16 = ((tmpvar_36.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_8.x));
					  tmpvar_19 = (((
					    ((tmpvar_36.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_21.w)) * tmpvar_8.w);
					  highp float tmpvar_37;
					  tmpvar_37 = dot (xlv_TEXCOORD1.xyz, tmpvar_15);
					  worldN_3.x = tmpvar_37;
					  highp float tmpvar_38;
					  tmpvar_38 = dot (xlv_TEXCOORD2.xyz, tmpvar_15);
					  worldN_3.y = tmpvar_38;
					  highp float tmpvar_39;
					  tmpvar_39 = dot (xlv_TEXCOORD3.xyz, tmpvar_15);
					  worldN_3.z = tmpvar_39;
					  lowp vec3 tmpvar_40;
					  tmpvar_40 = normalize(worldN_3);
					  worldN_3 = tmpvar_40;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 normalWorld_41;
					  normalWorld_41 = tmpvar_40;
					  mediump vec4 tmpvar_42;
					  tmpvar_42.w = 1.0;
					  tmpvar_42.xyz = normalWorld_41;
					  mediump vec3 x_43;
					  x_43.x = dot (unity_SHAr, tmpvar_42);
					  x_43.y = dot (unity_SHAg, tmpvar_42);
					  x_43.z = dot (unity_SHAb, tmpvar_42);
					  mediump vec3 tmpvar_44;
					  tmpvar_44 = max (((1.055 * 
					    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_43)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  mediump vec3 viewDir_45;
					  viewDir_45 = worldViewDir_5;
					  lowp vec4 c_46;
					  lowp vec4 c_47;
					  highp float nh_48;
					  lowp float diff_49;
					  mediump float tmpvar_50;
					  tmpvar_50 = max (0.0, dot (tmpvar_40, tmpvar_2));
					  diff_49 = tmpvar_50;
					  mediump float tmpvar_51;
					  tmpvar_51 = max (0.0, dot (tmpvar_40, normalize(
					    (tmpvar_2 + viewDir_45)
					  )));
					  nh_48 = tmpvar_51;
					  mediump float y_52;
					  y_52 = (tmpvar_17 * 128.0);
					  highp float tmpvar_53;
					  tmpvar_53 = (pow (nh_48, y_52) * tmpvar_18);
					  c_47.xyz = (((c_20.xyz * tmpvar_1) * diff_49) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_53));
					  c_47.w = tmpvar_19;
					  c_46.w = c_47.w;
					  c_46.xyz = (c_47.xyz + (c_20.xyz * tmpvar_44));
					  c_4.w = c_46.w;
					  c_4.xyz = (c_46.xyz + tmpvar_16);
					  highp float tmpvar_54;
					  tmpvar_54 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = mix (unity_FogColor.xyz, c_4.xyz, vec3(tmpvar_54));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
			}
		}
		Pass {
			Name "FORWARD"
			LOD 400
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 99471
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xyz;
					  highp float tmpvar_35;
					  tmpvar_35 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_36;
					  tmpvar_36 = texture2D (_LightTexture0, vec2(tmpvar_35)).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_5;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_15 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_16);
					  c_40.xyz = (((c_18.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_17;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  gl_FragData[0] = c_39;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xyz;
					  highp float tmpvar_35;
					  tmpvar_35 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_36;
					  tmpvar_36 = texture2D (_LightTexture0, vec2(tmpvar_35)).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_5;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_15 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_16);
					  c_40.xyz = (((c_18.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_17;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  gl_FragData[0] = c_39;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xyz;
					  highp float tmpvar_35;
					  tmpvar_35 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_36;
					  tmpvar_36 = texture2D (_LightTexture0, vec2(tmpvar_35)).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_5;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_15 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_16);
					  c_40.xyz = (((c_18.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_17;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  gl_FragData[0] = c_39;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec3 worldViewDir_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  tmpvar_11 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_4 = tmpvar_12;
					  tmpvar_6 = -(worldViewDir_4);
					  tmpvar_8 = xlv_TEXCOORD1;
					  tmpvar_9 = xlv_TEXCOORD2;
					  tmpvar_10 = xlv_TEXCOORD3;
					  tmpvar_7 = xlv_COLOR0;
					  lowp vec3 tmpvar_13;
					  mediump float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp vec4 c_17;
					  lowp vec4 fc_18;
					  highp vec3 norm2_19;
					  highp vec3 norm1_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_22;
					  tmpvar_22 = (xlv_TEXCOORD0.xy + vec2(tmpvar_21));
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = (xlv_TEXCOORD0.x - tmpvar_21);
					  tmpvar_23.y = ((xlv_TEXCOORD0.y + tmpvar_21) + 0.5);
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm1_20 = tmpvar_24;
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm2_19 = tmpvar_25;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = ((norm1_20 + norm2_19) * 0.5);
					  highp vec2 tmpvar_27;
					  tmpvar_27.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_28;
					  tmpvar_28 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_27.y = (xlv_TEXCOORD0.w + tmpvar_28);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + (tmpvar_28 * 0.5));
					  fc_18 = ((texture2D (_SplashTex, tmpvar_27) + texture2D (_SplashTex, tmpvar_29)) * 0.5);
					  highp vec4 tmpvar_30;
					  tmpvar_30 = ((_Color * (1.0 - tmpvar_7.x)) + (tmpvar_7.x * fc_18));
					  c_17 = tmpvar_30;
					  tmpvar_15 = (1.0 - tmpvar_7.x);
					  tmpvar_14 = (_Shininess * (1.0 - tmpvar_7.x));
					  tmpvar_13 = tmpvar_26;
					  mediump vec3 tmpvar_31;
					  tmpvar_31.x = dot (tmpvar_8, tmpvar_13);
					  tmpvar_31.y = dot (tmpvar_9, tmpvar_13);
					  tmpvar_31.z = dot (tmpvar_10, tmpvar_13);
					  highp vec3 tmpvar_32;
					  tmpvar_32 = (tmpvar_6 - (2.0 * (
					    dot (tmpvar_31, tmpvar_6)
					   * tmpvar_31)));
					  tmpvar_16 = (((
					    ((textureCube (_Cube, tmpvar_32).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_7.x)
					  ) + (tmpvar_7.x * fc_18.w)) * tmpvar_7.w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_13);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_13);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_13);
					  lowp vec3 tmpvar_33;
					  tmpvar_33 = normalize(worldN_3);
					  worldN_3 = tmpvar_33;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  mediump vec3 viewDir_34;
					  viewDir_34 = worldViewDir_4;
					  lowp vec4 c_35;
					  lowp vec4 c_36;
					  highp float nh_37;
					  lowp float diff_38;
					  mediump float tmpvar_39;
					  tmpvar_39 = max (0.0, dot (tmpvar_33, tmpvar_2));
					  diff_38 = tmpvar_39;
					  mediump float tmpvar_40;
					  tmpvar_40 = max (0.0, dot (tmpvar_33, normalize(
					    (tmpvar_2 + viewDir_34)
					  )));
					  nh_37 = tmpvar_40;
					  mediump float y_41;
					  y_41 = (tmpvar_14 * 128.0);
					  highp float tmpvar_42;
					  tmpvar_42 = (pow (nh_37, y_41) * tmpvar_15);
					  c_36.xyz = (((c_17.xyz * tmpvar_1) * diff_38) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_42));
					  c_36.w = tmpvar_16;
					  c_35.w = c_36.w;
					  c_35.xyz = c_36.xyz;
					  gl_FragData[0] = c_35;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec3 worldViewDir_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  tmpvar_11 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_4 = tmpvar_12;
					  tmpvar_6 = -(worldViewDir_4);
					  tmpvar_8 = xlv_TEXCOORD1;
					  tmpvar_9 = xlv_TEXCOORD2;
					  tmpvar_10 = xlv_TEXCOORD3;
					  tmpvar_7 = xlv_COLOR0;
					  lowp vec3 tmpvar_13;
					  mediump float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp vec4 c_17;
					  lowp vec4 fc_18;
					  highp vec3 norm2_19;
					  highp vec3 norm1_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_22;
					  tmpvar_22 = (xlv_TEXCOORD0.xy + vec2(tmpvar_21));
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = (xlv_TEXCOORD0.x - tmpvar_21);
					  tmpvar_23.y = ((xlv_TEXCOORD0.y + tmpvar_21) + 0.5);
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm1_20 = tmpvar_24;
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm2_19 = tmpvar_25;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = ((norm1_20 + norm2_19) * 0.5);
					  highp vec2 tmpvar_27;
					  tmpvar_27.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_28;
					  tmpvar_28 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_27.y = (xlv_TEXCOORD0.w + tmpvar_28);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + (tmpvar_28 * 0.5));
					  fc_18 = ((texture2D (_SplashTex, tmpvar_27) + texture2D (_SplashTex, tmpvar_29)) * 0.5);
					  highp vec4 tmpvar_30;
					  tmpvar_30 = ((_Color * (1.0 - tmpvar_7.x)) + (tmpvar_7.x * fc_18));
					  c_17 = tmpvar_30;
					  tmpvar_15 = (1.0 - tmpvar_7.x);
					  tmpvar_14 = (_Shininess * (1.0 - tmpvar_7.x));
					  tmpvar_13 = tmpvar_26;
					  mediump vec3 tmpvar_31;
					  tmpvar_31.x = dot (tmpvar_8, tmpvar_13);
					  tmpvar_31.y = dot (tmpvar_9, tmpvar_13);
					  tmpvar_31.z = dot (tmpvar_10, tmpvar_13);
					  highp vec3 tmpvar_32;
					  tmpvar_32 = (tmpvar_6 - (2.0 * (
					    dot (tmpvar_31, tmpvar_6)
					   * tmpvar_31)));
					  tmpvar_16 = (((
					    ((textureCube (_Cube, tmpvar_32).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_7.x)
					  ) + (tmpvar_7.x * fc_18.w)) * tmpvar_7.w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_13);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_13);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_13);
					  lowp vec3 tmpvar_33;
					  tmpvar_33 = normalize(worldN_3);
					  worldN_3 = tmpvar_33;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  mediump vec3 viewDir_34;
					  viewDir_34 = worldViewDir_4;
					  lowp vec4 c_35;
					  lowp vec4 c_36;
					  highp float nh_37;
					  lowp float diff_38;
					  mediump float tmpvar_39;
					  tmpvar_39 = max (0.0, dot (tmpvar_33, tmpvar_2));
					  diff_38 = tmpvar_39;
					  mediump float tmpvar_40;
					  tmpvar_40 = max (0.0, dot (tmpvar_33, normalize(
					    (tmpvar_2 + viewDir_34)
					  )));
					  nh_37 = tmpvar_40;
					  mediump float y_41;
					  y_41 = (tmpvar_14 * 128.0);
					  highp float tmpvar_42;
					  tmpvar_42 = (pow (nh_37, y_41) * tmpvar_15);
					  c_36.xyz = (((c_17.xyz * tmpvar_1) * diff_38) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_42));
					  c_36.w = tmpvar_16;
					  c_35.w = c_36.w;
					  c_35.xyz = c_36.xyz;
					  gl_FragData[0] = c_35;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec3 worldViewDir_4;
					  lowp vec3 lightDir_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  tmpvar_11 = _WorldSpaceLightPos0.xyz;
					  lightDir_5 = tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_4 = tmpvar_12;
					  tmpvar_6 = -(worldViewDir_4);
					  tmpvar_8 = xlv_TEXCOORD1;
					  tmpvar_9 = xlv_TEXCOORD2;
					  tmpvar_10 = xlv_TEXCOORD3;
					  tmpvar_7 = xlv_COLOR0;
					  lowp vec3 tmpvar_13;
					  mediump float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp vec4 c_17;
					  lowp vec4 fc_18;
					  highp vec3 norm2_19;
					  highp vec3 norm1_20;
					  highp float tmpvar_21;
					  tmpvar_21 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_22;
					  tmpvar_22 = (xlv_TEXCOORD0.xy + vec2(tmpvar_21));
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = (xlv_TEXCOORD0.x - tmpvar_21);
					  tmpvar_23.y = ((xlv_TEXCOORD0.y + tmpvar_21) + 0.5);
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm1_20 = tmpvar_24;
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm2_19 = tmpvar_25;
					  highp vec3 tmpvar_26;
					  tmpvar_26 = ((norm1_20 + norm2_19) * 0.5);
					  highp vec2 tmpvar_27;
					  tmpvar_27.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_28;
					  tmpvar_28 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_27.y = (xlv_TEXCOORD0.w + tmpvar_28);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + (tmpvar_28 * 0.5));
					  fc_18 = ((texture2D (_SplashTex, tmpvar_27) + texture2D (_SplashTex, tmpvar_29)) * 0.5);
					  highp vec4 tmpvar_30;
					  tmpvar_30 = ((_Color * (1.0 - tmpvar_7.x)) + (tmpvar_7.x * fc_18));
					  c_17 = tmpvar_30;
					  tmpvar_15 = (1.0 - tmpvar_7.x);
					  tmpvar_14 = (_Shininess * (1.0 - tmpvar_7.x));
					  tmpvar_13 = tmpvar_26;
					  mediump vec3 tmpvar_31;
					  tmpvar_31.x = dot (tmpvar_8, tmpvar_13);
					  tmpvar_31.y = dot (tmpvar_9, tmpvar_13);
					  tmpvar_31.z = dot (tmpvar_10, tmpvar_13);
					  highp vec3 tmpvar_32;
					  tmpvar_32 = (tmpvar_6 - (2.0 * (
					    dot (tmpvar_31, tmpvar_6)
					   * tmpvar_31)));
					  tmpvar_16 = (((
					    ((textureCube (_Cube, tmpvar_32).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_7.x)
					  ) + (tmpvar_7.x * fc_18.w)) * tmpvar_7.w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_13);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_13);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_13);
					  lowp vec3 tmpvar_33;
					  tmpvar_33 = normalize(worldN_3);
					  worldN_3 = tmpvar_33;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_5;
					  mediump vec3 viewDir_34;
					  viewDir_34 = worldViewDir_4;
					  lowp vec4 c_35;
					  lowp vec4 c_36;
					  highp float nh_37;
					  lowp float diff_38;
					  mediump float tmpvar_39;
					  tmpvar_39 = max (0.0, dot (tmpvar_33, tmpvar_2));
					  diff_38 = tmpvar_39;
					  mediump float tmpvar_40;
					  tmpvar_40 = max (0.0, dot (tmpvar_33, normalize(
					    (tmpvar_2 + viewDir_34)
					  )));
					  nh_37 = tmpvar_40;
					  mediump float y_41;
					  y_41 = (tmpvar_14 * 128.0);
					  highp float tmpvar_42;
					  tmpvar_42 = (pow (nh_37, y_41) * tmpvar_15);
					  c_36.xyz = (((c_17.xyz * tmpvar_1) * diff_38) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_42));
					  c_36.w = tmpvar_16;
					  c_35.w = c_36.w;
					  c_35.xyz = c_36.xyz;
					  gl_FragData[0] = c_35;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp float atten_4;
					  highp vec4 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35);
					  lowp vec4 tmpvar_36;
					  highp vec2 P_37;
					  P_37 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_36 = texture2D (_LightTexture0, P_37);
					  highp float tmpvar_38;
					  tmpvar_38 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_LightTextureB0, vec2(tmpvar_38));
					  highp float tmpvar_40;
					  tmpvar_40 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_36.w) * tmpvar_39.w);
					  atten_4 = tmpvar_40;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_41;
					  tmpvar_41 = normalize(worldN_3);
					  worldN_3 = tmpvar_41;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  mediump vec3 viewDir_42;
					  viewDir_42 = worldViewDir_6;
					  lowp vec4 c_43;
					  lowp vec4 c_44;
					  highp float nh_45;
					  lowp float diff_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_41, tmpvar_2));
					  diff_46 = tmpvar_47;
					  mediump float tmpvar_48;
					  tmpvar_48 = max (0.0, dot (tmpvar_41, normalize(
					    (tmpvar_2 + viewDir_42)
					  )));
					  nh_45 = tmpvar_48;
					  mediump float y_49;
					  y_49 = (tmpvar_16 * 128.0);
					  highp float tmpvar_50;
					  tmpvar_50 = (pow (nh_45, y_49) * tmpvar_17);
					  c_44.xyz = (((c_19.xyz * tmpvar_1) * diff_46) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_50));
					  c_44.w = tmpvar_18;
					  c_43.w = c_44.w;
					  c_43.xyz = c_44.xyz;
					  gl_FragData[0] = c_43;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp float atten_4;
					  highp vec4 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35);
					  lowp vec4 tmpvar_36;
					  highp vec2 P_37;
					  P_37 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_36 = texture2D (_LightTexture0, P_37);
					  highp float tmpvar_38;
					  tmpvar_38 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_LightTextureB0, vec2(tmpvar_38));
					  highp float tmpvar_40;
					  tmpvar_40 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_36.w) * tmpvar_39.w);
					  atten_4 = tmpvar_40;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_41;
					  tmpvar_41 = normalize(worldN_3);
					  worldN_3 = tmpvar_41;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  mediump vec3 viewDir_42;
					  viewDir_42 = worldViewDir_6;
					  lowp vec4 c_43;
					  lowp vec4 c_44;
					  highp float nh_45;
					  lowp float diff_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_41, tmpvar_2));
					  diff_46 = tmpvar_47;
					  mediump float tmpvar_48;
					  tmpvar_48 = max (0.0, dot (tmpvar_41, normalize(
					    (tmpvar_2 + viewDir_42)
					  )));
					  nh_45 = tmpvar_48;
					  mediump float y_49;
					  y_49 = (tmpvar_16 * 128.0);
					  highp float tmpvar_50;
					  tmpvar_50 = (pow (nh_45, y_49) * tmpvar_17);
					  c_44.xyz = (((c_19.xyz * tmpvar_1) * diff_46) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_50));
					  c_44.w = tmpvar_18;
					  c_43.w = c_44.w;
					  c_43.xyz = c_44.xyz;
					  gl_FragData[0] = c_43;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp float atten_4;
					  highp vec4 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35);
					  lowp vec4 tmpvar_36;
					  highp vec2 P_37;
					  P_37 = ((lightCoord_5.xy / lightCoord_5.w) + 0.5);
					  tmpvar_36 = texture2D (_LightTexture0, P_37);
					  highp float tmpvar_38;
					  tmpvar_38 = dot (lightCoord_5.xyz, lightCoord_5.xyz);
					  lowp vec4 tmpvar_39;
					  tmpvar_39 = texture2D (_LightTextureB0, vec2(tmpvar_38));
					  highp float tmpvar_40;
					  tmpvar_40 = ((float(
					    (lightCoord_5.z > 0.0)
					  ) * tmpvar_36.w) * tmpvar_39.w);
					  atten_4 = tmpvar_40;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_41;
					  tmpvar_41 = normalize(worldN_3);
					  worldN_3 = tmpvar_41;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * atten_4);
					  mediump vec3 viewDir_42;
					  viewDir_42 = worldViewDir_6;
					  lowp vec4 c_43;
					  lowp vec4 c_44;
					  highp float nh_45;
					  lowp float diff_46;
					  mediump float tmpvar_47;
					  tmpvar_47 = max (0.0, dot (tmpvar_41, tmpvar_2));
					  diff_46 = tmpvar_47;
					  mediump float tmpvar_48;
					  tmpvar_48 = max (0.0, dot (tmpvar_41, normalize(
					    (tmpvar_2 + viewDir_42)
					  )));
					  nh_45 = tmpvar_48;
					  mediump float y_49;
					  y_49 = (tmpvar_16 * 128.0);
					  highp float tmpvar_50;
					  tmpvar_50 = (pow (nh_45, y_49) * tmpvar_17);
					  c_44.xyz = (((c_19.xyz * tmpvar_1) * diff_46) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_50));
					  c_44.w = tmpvar_18;
					  c_43.w = c_44.w;
					  c_43.xyz = c_44.xyz;
					  gl_FragData[0] = c_43;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xyz;
					  highp float tmpvar_35;
					  tmpvar_35 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_36;
					  tmpvar_36 = (texture2D (_LightTextureB0, vec2(tmpvar_35)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_5;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_15 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_16);
					  c_40.xyz = (((c_18.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_17;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  gl_FragData[0] = c_39;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xyz;
					  highp float tmpvar_35;
					  tmpvar_35 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_36;
					  tmpvar_36 = (texture2D (_LightTextureB0, vec2(tmpvar_35)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_5;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_15 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_16);
					  c_40.xyz = (((c_18.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_17;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  gl_FragData[0] = c_39;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec3 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xyz;
					  highp float tmpvar_35;
					  tmpvar_35 = dot (lightCoord_4, lightCoord_4);
					  lowp float tmpvar_36;
					  tmpvar_36 = (texture2D (_LightTextureB0, vec2(tmpvar_35)).w * textureCube (_LightTexture0, lightCoord_4).w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_5;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_15 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_16);
					  c_40.xyz = (((c_18.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_17;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  gl_FragData[0] = c_39;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec2 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xy;
					  lowp float tmpvar_35;
					  tmpvar_35 = texture2D (_LightTexture0, lightCoord_4).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_36;
					  tmpvar_36 = normalize(worldN_3);
					  worldN_3 = tmpvar_36;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_35);
					  mediump vec3 viewDir_37;
					  viewDir_37 = worldViewDir_5;
					  lowp vec4 c_38;
					  lowp vec4 c_39;
					  highp float nh_40;
					  lowp float diff_41;
					  mediump float tmpvar_42;
					  tmpvar_42 = max (0.0, dot (tmpvar_36, tmpvar_2));
					  diff_41 = tmpvar_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_36, normalize(
					    (tmpvar_2 + viewDir_37)
					  )));
					  nh_40 = tmpvar_43;
					  mediump float y_44;
					  y_44 = (tmpvar_15 * 128.0);
					  highp float tmpvar_45;
					  tmpvar_45 = (pow (nh_40, y_44) * tmpvar_16);
					  c_39.xyz = (((c_18.xyz * tmpvar_1) * diff_41) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_45));
					  c_39.w = tmpvar_17;
					  c_38.w = c_39.w;
					  c_38.xyz = c_39.xyz;
					  gl_FragData[0] = c_38;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec2 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xy;
					  lowp float tmpvar_35;
					  tmpvar_35 = texture2D (_LightTexture0, lightCoord_4).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_36;
					  tmpvar_36 = normalize(worldN_3);
					  worldN_3 = tmpvar_36;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_35);
					  mediump vec3 viewDir_37;
					  viewDir_37 = worldViewDir_5;
					  lowp vec4 c_38;
					  lowp vec4 c_39;
					  highp float nh_40;
					  lowp float diff_41;
					  mediump float tmpvar_42;
					  tmpvar_42 = max (0.0, dot (tmpvar_36, tmpvar_2));
					  diff_41 = tmpvar_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_36, normalize(
					    (tmpvar_2 + viewDir_37)
					  )));
					  nh_40 = tmpvar_43;
					  mediump float y_44;
					  y_44 = (tmpvar_15 * 128.0);
					  highp float tmpvar_45;
					  tmpvar_45 = (pow (nh_40, y_44) * tmpvar_16);
					  c_39.xyz = (((c_18.xyz * tmpvar_1) * diff_41) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_45));
					  c_39.w = tmpvar_17;
					  c_38.w = c_39.w;
					  c_38.xyz = c_39.xyz;
					  gl_FragData[0] = c_38;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_7;
					  tmpvar_7[0] = unity_WorldToObject[0].xyz;
					  tmpvar_7[1] = unity_WorldToObject[1].xyz;
					  tmpvar_7[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_8;
					  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
					  worldNormal_3 = tmpvar_8;
					  highp mat3 tmpvar_9;
					  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_10;
					  highp float tmpvar_11;
					  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_11;
					  lowp vec3 tmpvar_12;
					  tmpvar_12 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_13;
					  tmpvar_13.x = worldTangent_2.x;
					  tmpvar_13.y = tmpvar_12.x;
					  tmpvar_13.z = worldNormal_3.x;
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.y;
					  tmpvar_14.y = tmpvar_12.y;
					  tmpvar_14.z = worldNormal_3.y;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.z;
					  tmpvar_15.y = tmpvar_12.z;
					  tmpvar_15.z = worldNormal_3.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_13;
					  xlv_TEXCOORD2 = tmpvar_14;
					  xlv_TEXCOORD3 = tmpvar_15;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  highp vec2 lightCoord_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  highp vec4 tmpvar_34;
					  tmpvar_34.w = 1.0;
					  tmpvar_34.xyz = xlv_TEXCOORD4;
					  lightCoord_4 = (unity_WorldToLight * tmpvar_34).xy;
					  lowp float tmpvar_35;
					  tmpvar_35 = texture2D (_LightTexture0, lightCoord_4).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_36;
					  tmpvar_36 = normalize(worldN_3);
					  worldN_3 = tmpvar_36;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  tmpvar_1 = (tmpvar_1 * tmpvar_35);
					  mediump vec3 viewDir_37;
					  viewDir_37 = worldViewDir_5;
					  lowp vec4 c_38;
					  lowp vec4 c_39;
					  highp float nh_40;
					  lowp float diff_41;
					  mediump float tmpvar_42;
					  tmpvar_42 = max (0.0, dot (tmpvar_36, tmpvar_2));
					  diff_41 = tmpvar_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_36, normalize(
					    (tmpvar_2 + viewDir_37)
					  )));
					  nh_40 = tmpvar_43;
					  mediump float y_44;
					  y_44 = (tmpvar_15 * 128.0);
					  highp float tmpvar_45;
					  tmpvar_45 = (pow (nh_40, y_44) * tmpvar_16);
					  c_39.xyz = (((c_18.xyz * tmpvar_1) * diff_41) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_45));
					  c_39.w = tmpvar_17;
					  c_38.w = c_39.w;
					  c_38.xyz = c_39.xyz;
					  gl_FragData[0] = c_38;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec3 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xyz;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (lightCoord_5, lightCoord_5);
					  lowp float tmpvar_37;
					  tmpvar_37 = texture2D (_LightTexture0, vec2(tmpvar_36)).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_38;
					  tmpvar_38 = normalize(worldN_3);
					  worldN_3 = tmpvar_38;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_37);
					  mediump vec3 viewDir_39;
					  viewDir_39 = worldViewDir_6;
					  lowp vec4 c_40;
					  lowp vec4 c_41;
					  highp float nh_42;
					  lowp float diff_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_38, tmpvar_2));
					  diff_43 = tmpvar_44;
					  mediump float tmpvar_45;
					  tmpvar_45 = max (0.0, dot (tmpvar_38, normalize(
					    (tmpvar_2 + viewDir_39)
					  )));
					  nh_42 = tmpvar_45;
					  mediump float y_46;
					  y_46 = (tmpvar_16 * 128.0);
					  highp float tmpvar_47;
					  tmpvar_47 = (pow (nh_42, y_46) * tmpvar_17);
					  c_41.xyz = (((c_19.xyz * tmpvar_1) * diff_43) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_47));
					  c_41.w = tmpvar_18;
					  c_40.w = c_41.w;
					  c_40.xyz = c_41.xyz;
					  c_4.w = c_40.w;
					  highp float tmpvar_48;
					  tmpvar_48 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_41.xyz * vec3(tmpvar_48));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec3 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xyz;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (lightCoord_5, lightCoord_5);
					  lowp float tmpvar_37;
					  tmpvar_37 = texture2D (_LightTexture0, vec2(tmpvar_36)).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_38;
					  tmpvar_38 = normalize(worldN_3);
					  worldN_3 = tmpvar_38;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_37);
					  mediump vec3 viewDir_39;
					  viewDir_39 = worldViewDir_6;
					  lowp vec4 c_40;
					  lowp vec4 c_41;
					  highp float nh_42;
					  lowp float diff_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_38, tmpvar_2));
					  diff_43 = tmpvar_44;
					  mediump float tmpvar_45;
					  tmpvar_45 = max (0.0, dot (tmpvar_38, normalize(
					    (tmpvar_2 + viewDir_39)
					  )));
					  nh_42 = tmpvar_45;
					  mediump float y_46;
					  y_46 = (tmpvar_16 * 128.0);
					  highp float tmpvar_47;
					  tmpvar_47 = (pow (nh_42, y_46) * tmpvar_17);
					  c_41.xyz = (((c_19.xyz * tmpvar_1) * diff_43) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_47));
					  c_41.w = tmpvar_18;
					  c_40.w = c_41.w;
					  c_40.xyz = c_41.xyz;
					  c_4.w = c_40.w;
					  highp float tmpvar_48;
					  tmpvar_48 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_41.xyz * vec3(tmpvar_48));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec3 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xyz;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (lightCoord_5, lightCoord_5);
					  lowp float tmpvar_37;
					  tmpvar_37 = texture2D (_LightTexture0, vec2(tmpvar_36)).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_38;
					  tmpvar_38 = normalize(worldN_3);
					  worldN_3 = tmpvar_38;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_37);
					  mediump vec3 viewDir_39;
					  viewDir_39 = worldViewDir_6;
					  lowp vec4 c_40;
					  lowp vec4 c_41;
					  highp float nh_42;
					  lowp float diff_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_38, tmpvar_2));
					  diff_43 = tmpvar_44;
					  mediump float tmpvar_45;
					  tmpvar_45 = max (0.0, dot (tmpvar_38, normalize(
					    (tmpvar_2 + viewDir_39)
					  )));
					  nh_42 = tmpvar_45;
					  mediump float y_46;
					  y_46 = (tmpvar_16 * 128.0);
					  highp float tmpvar_47;
					  tmpvar_47 = (pow (nh_42, y_46) * tmpvar_17);
					  c_41.xyz = (((c_19.xyz * tmpvar_1) * diff_43) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_47));
					  c_41.w = tmpvar_18;
					  c_40.w = c_41.w;
					  c_40.xyz = c_41.xyz;
					  c_4.w = c_40.w;
					  highp float tmpvar_48;
					  tmpvar_48 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_41.xyz * vec3(tmpvar_48));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_34;
					  tmpvar_34 = normalize(worldN_3);
					  worldN_3 = tmpvar_34;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_35;
					  viewDir_35 = worldViewDir_5;
					  lowp vec4 c_36;
					  lowp vec4 c_37;
					  highp float nh_38;
					  lowp float diff_39;
					  mediump float tmpvar_40;
					  tmpvar_40 = max (0.0, dot (tmpvar_34, tmpvar_2));
					  diff_39 = tmpvar_40;
					  mediump float tmpvar_41;
					  tmpvar_41 = max (0.0, dot (tmpvar_34, normalize(
					    (tmpvar_2 + viewDir_35)
					  )));
					  nh_38 = tmpvar_41;
					  mediump float y_42;
					  y_42 = (tmpvar_15 * 128.0);
					  highp float tmpvar_43;
					  tmpvar_43 = (pow (nh_38, y_42) * tmpvar_16);
					  c_37.xyz = (((c_18.xyz * tmpvar_1) * diff_39) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_43));
					  c_37.w = tmpvar_17;
					  c_36.w = c_37.w;
					  c_36.xyz = c_37.xyz;
					  c_4.w = c_36.w;
					  highp float tmpvar_44;
					  tmpvar_44 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_37.xyz * vec3(tmpvar_44));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_34;
					  tmpvar_34 = normalize(worldN_3);
					  worldN_3 = tmpvar_34;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_35;
					  viewDir_35 = worldViewDir_5;
					  lowp vec4 c_36;
					  lowp vec4 c_37;
					  highp float nh_38;
					  lowp float diff_39;
					  mediump float tmpvar_40;
					  tmpvar_40 = max (0.0, dot (tmpvar_34, tmpvar_2));
					  diff_39 = tmpvar_40;
					  mediump float tmpvar_41;
					  tmpvar_41 = max (0.0, dot (tmpvar_34, normalize(
					    (tmpvar_2 + viewDir_35)
					  )));
					  nh_38 = tmpvar_41;
					  mediump float y_42;
					  y_42 = (tmpvar_15 * 128.0);
					  highp float tmpvar_43;
					  tmpvar_43 = (pow (nh_38, y_42) * tmpvar_16);
					  c_37.xyz = (((c_18.xyz * tmpvar_1) * diff_39) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_43));
					  c_37.w = tmpvar_17;
					  c_36.w = c_37.w;
					  c_36.xyz = c_37.xyz;
					  c_4.w = c_36.w;
					  highp float tmpvar_44;
					  tmpvar_44 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_37.xyz * vec3(tmpvar_44));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp vec3 worldViewDir_5;
					  lowp vec3 lightDir_6;
					  highp vec3 tmpvar_7;
					  highp vec4 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  tmpvar_12 = _WorldSpaceLightPos0.xyz;
					  lightDir_6 = tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_5 = tmpvar_13;
					  tmpvar_7 = -(worldViewDir_5);
					  tmpvar_9 = xlv_TEXCOORD1;
					  tmpvar_10 = xlv_TEXCOORD2;
					  tmpvar_11 = xlv_TEXCOORD3;
					  tmpvar_8 = xlv_COLOR0;
					  lowp vec3 tmpvar_14;
					  mediump float tmpvar_15;
					  lowp float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp vec4 c_18;
					  lowp vec4 fc_19;
					  highp vec3 norm2_20;
					  highp vec3 norm1_21;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_23;
					  tmpvar_23 = (xlv_TEXCOORD0.xy + vec2(tmpvar_22));
					  highp vec2 tmpvar_24;
					  tmpvar_24.x = (xlv_TEXCOORD0.x - tmpvar_22);
					  tmpvar_24.y = ((xlv_TEXCOORD0.y + tmpvar_22) + 0.5);
					  lowp vec3 tmpvar_25;
					  tmpvar_25 = ((texture2D (_BumpMap, tmpvar_23).xyz * 2.0) - 1.0);
					  norm1_21 = tmpvar_25;
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm2_20 = tmpvar_26;
					  highp vec3 tmpvar_27;
					  tmpvar_27 = ((norm1_21 + norm2_20) * 0.5);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_29;
					  tmpvar_29 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + tmpvar_29);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + (tmpvar_29 * 0.5));
					  fc_19 = ((texture2D (_SplashTex, tmpvar_28) + texture2D (_SplashTex, tmpvar_30)) * 0.5);
					  highp vec4 tmpvar_31;
					  tmpvar_31 = ((_Color * (1.0 - tmpvar_8.x)) + (tmpvar_8.x * fc_19));
					  c_18 = tmpvar_31;
					  tmpvar_16 = (1.0 - tmpvar_8.x);
					  tmpvar_15 = (_Shininess * (1.0 - tmpvar_8.x));
					  tmpvar_14 = tmpvar_27;
					  mediump vec3 tmpvar_32;
					  tmpvar_32.x = dot (tmpvar_9, tmpvar_14);
					  tmpvar_32.y = dot (tmpvar_10, tmpvar_14);
					  tmpvar_32.z = dot (tmpvar_11, tmpvar_14);
					  highp vec3 tmpvar_33;
					  tmpvar_33 = (tmpvar_7 - (2.0 * (
					    dot (tmpvar_32, tmpvar_7)
					   * tmpvar_32)));
					  tmpvar_17 = (((
					    ((textureCube (_Cube, tmpvar_33).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_8.x)
					  ) + (tmpvar_8.x * fc_19.w)) * tmpvar_8.w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_14);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_14);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_14);
					  lowp vec3 tmpvar_34;
					  tmpvar_34 = normalize(worldN_3);
					  worldN_3 = tmpvar_34;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_6;
					  mediump vec3 viewDir_35;
					  viewDir_35 = worldViewDir_5;
					  lowp vec4 c_36;
					  lowp vec4 c_37;
					  highp float nh_38;
					  lowp float diff_39;
					  mediump float tmpvar_40;
					  tmpvar_40 = max (0.0, dot (tmpvar_34, tmpvar_2));
					  diff_39 = tmpvar_40;
					  mediump float tmpvar_41;
					  tmpvar_41 = max (0.0, dot (tmpvar_34, normalize(
					    (tmpvar_2 + viewDir_35)
					  )));
					  nh_38 = tmpvar_41;
					  mediump float y_42;
					  y_42 = (tmpvar_15 * 128.0);
					  highp float tmpvar_43;
					  tmpvar_43 = (pow (nh_38, y_42) * tmpvar_16);
					  c_37.xyz = (((c_18.xyz * tmpvar_1) * diff_39) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_43));
					  c_37.w = tmpvar_17;
					  c_36.w = c_37.w;
					  c_36.xyz = c_37.xyz;
					  c_4.w = c_36.w;
					  highp float tmpvar_44;
					  tmpvar_44 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_37.xyz * vec3(tmpvar_44));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  highp vec4 lightCoord_6;
					  lowp vec3 worldViewDir_7;
					  lowp vec3 lightDir_8;
					  highp vec3 tmpvar_9;
					  highp vec4 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  mediump vec3 tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_8 = tmpvar_14;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_7 = tmpvar_15;
					  tmpvar_9 = -(worldViewDir_7);
					  tmpvar_11 = xlv_TEXCOORD1;
					  tmpvar_12 = xlv_TEXCOORD2;
					  tmpvar_13 = xlv_TEXCOORD3;
					  tmpvar_10 = xlv_COLOR0;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_10.x)) + (tmpvar_10.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_10.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_10.x));
					  tmpvar_16 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_11, tmpvar_16);
					  tmpvar_34.y = dot (tmpvar_12, tmpvar_16);
					  tmpvar_34.z = dot (tmpvar_13, tmpvar_16);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_9 - (2.0 * (
					    dot (tmpvar_34, tmpvar_9)
					   * tmpvar_34)));
					  tmpvar_19 = (((
					    ((textureCube (_Cube, tmpvar_35).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_10.x)
					  ) + (tmpvar_10.x * fc_21.w)) * tmpvar_10.w);
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = xlv_TEXCOORD4;
					  lightCoord_6 = (unity_WorldToLight * tmpvar_36);
					  lowp vec4 tmpvar_37;
					  highp vec2 P_38;
					  P_38 = ((lightCoord_6.xy / lightCoord_6.w) + 0.5);
					  tmpvar_37 = texture2D (_LightTexture0, P_38);
					  highp float tmpvar_39;
					  tmpvar_39 = dot (lightCoord_6.xyz, lightCoord_6.xyz);
					  lowp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_LightTextureB0, vec2(tmpvar_39));
					  highp float tmpvar_41;
					  tmpvar_41 = ((float(
					    (lightCoord_6.z > 0.0)
					  ) * tmpvar_37.w) * tmpvar_40.w);
					  atten_5 = tmpvar_41;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_16);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_16);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_16);
					  lowp vec3 tmpvar_42;
					  tmpvar_42 = normalize(worldN_3);
					  worldN_3 = tmpvar_42;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_8;
					  tmpvar_1 = (tmpvar_1 * atten_5);
					  mediump vec3 viewDir_43;
					  viewDir_43 = worldViewDir_7;
					  lowp vec4 c_44;
					  lowp vec4 c_45;
					  highp float nh_46;
					  lowp float diff_47;
					  mediump float tmpvar_48;
					  tmpvar_48 = max (0.0, dot (tmpvar_42, tmpvar_2));
					  diff_47 = tmpvar_48;
					  mediump float tmpvar_49;
					  tmpvar_49 = max (0.0, dot (tmpvar_42, normalize(
					    (tmpvar_2 + viewDir_43)
					  )));
					  nh_46 = tmpvar_49;
					  mediump float y_50;
					  y_50 = (tmpvar_17 * 128.0);
					  highp float tmpvar_51;
					  tmpvar_51 = (pow (nh_46, y_50) * tmpvar_18);
					  c_45.xyz = (((c_20.xyz * tmpvar_1) * diff_47) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_51));
					  c_45.w = tmpvar_19;
					  c_44.w = c_45.w;
					  c_44.xyz = c_45.xyz;
					  c_4.w = c_44.w;
					  highp float tmpvar_52;
					  tmpvar_52 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_45.xyz * vec3(tmpvar_52));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  highp vec4 lightCoord_6;
					  lowp vec3 worldViewDir_7;
					  lowp vec3 lightDir_8;
					  highp vec3 tmpvar_9;
					  highp vec4 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  mediump vec3 tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_8 = tmpvar_14;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_7 = tmpvar_15;
					  tmpvar_9 = -(worldViewDir_7);
					  tmpvar_11 = xlv_TEXCOORD1;
					  tmpvar_12 = xlv_TEXCOORD2;
					  tmpvar_13 = xlv_TEXCOORD3;
					  tmpvar_10 = xlv_COLOR0;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_10.x)) + (tmpvar_10.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_10.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_10.x));
					  tmpvar_16 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_11, tmpvar_16);
					  tmpvar_34.y = dot (tmpvar_12, tmpvar_16);
					  tmpvar_34.z = dot (tmpvar_13, tmpvar_16);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_9 - (2.0 * (
					    dot (tmpvar_34, tmpvar_9)
					   * tmpvar_34)));
					  tmpvar_19 = (((
					    ((textureCube (_Cube, tmpvar_35).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_10.x)
					  ) + (tmpvar_10.x * fc_21.w)) * tmpvar_10.w);
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = xlv_TEXCOORD4;
					  lightCoord_6 = (unity_WorldToLight * tmpvar_36);
					  lowp vec4 tmpvar_37;
					  highp vec2 P_38;
					  P_38 = ((lightCoord_6.xy / lightCoord_6.w) + 0.5);
					  tmpvar_37 = texture2D (_LightTexture0, P_38);
					  highp float tmpvar_39;
					  tmpvar_39 = dot (lightCoord_6.xyz, lightCoord_6.xyz);
					  lowp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_LightTextureB0, vec2(tmpvar_39));
					  highp float tmpvar_41;
					  tmpvar_41 = ((float(
					    (lightCoord_6.z > 0.0)
					  ) * tmpvar_37.w) * tmpvar_40.w);
					  atten_5 = tmpvar_41;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_16);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_16);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_16);
					  lowp vec3 tmpvar_42;
					  tmpvar_42 = normalize(worldN_3);
					  worldN_3 = tmpvar_42;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_8;
					  tmpvar_1 = (tmpvar_1 * atten_5);
					  mediump vec3 viewDir_43;
					  viewDir_43 = worldViewDir_7;
					  lowp vec4 c_44;
					  lowp vec4 c_45;
					  highp float nh_46;
					  lowp float diff_47;
					  mediump float tmpvar_48;
					  tmpvar_48 = max (0.0, dot (tmpvar_42, tmpvar_2));
					  diff_47 = tmpvar_48;
					  mediump float tmpvar_49;
					  tmpvar_49 = max (0.0, dot (tmpvar_42, normalize(
					    (tmpvar_2 + viewDir_43)
					  )));
					  nh_46 = tmpvar_49;
					  mediump float y_50;
					  y_50 = (tmpvar_17 * 128.0);
					  highp float tmpvar_51;
					  tmpvar_51 = (pow (nh_46, y_50) * tmpvar_18);
					  c_45.xyz = (((c_20.xyz * tmpvar_1) * diff_47) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_51));
					  c_45.w = tmpvar_19;
					  c_44.w = c_45.w;
					  c_44.xyz = c_45.xyz;
					  c_4.w = c_44.w;
					  highp float tmpvar_52;
					  tmpvar_52 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_45.xyz * vec3(tmpvar_52));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  lowp float atten_5;
					  highp vec4 lightCoord_6;
					  lowp vec3 worldViewDir_7;
					  lowp vec3 lightDir_8;
					  highp vec3 tmpvar_9;
					  highp vec4 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  mediump vec3 tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_8 = tmpvar_14;
					  highp vec3 tmpvar_15;
					  tmpvar_15 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_7 = tmpvar_15;
					  tmpvar_9 = -(worldViewDir_7);
					  tmpvar_11 = xlv_TEXCOORD1;
					  tmpvar_12 = xlv_TEXCOORD2;
					  tmpvar_13 = xlv_TEXCOORD3;
					  tmpvar_10 = xlv_COLOR0;
					  lowp vec3 tmpvar_16;
					  mediump float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp float tmpvar_19;
					  lowp vec4 c_20;
					  lowp vec4 fc_21;
					  highp vec3 norm2_22;
					  highp vec3 norm1_23;
					  highp float tmpvar_24;
					  tmpvar_24 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_25;
					  tmpvar_25 = (xlv_TEXCOORD0.xy + vec2(tmpvar_24));
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = (xlv_TEXCOORD0.x - tmpvar_24);
					  tmpvar_26.y = ((xlv_TEXCOORD0.y + tmpvar_24) + 0.5);
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm1_23 = tmpvar_27;
					  lowp vec3 tmpvar_28;
					  tmpvar_28 = ((texture2D (_BumpMap, tmpvar_26).xyz * 2.0) - 1.0);
					  norm2_22 = tmpvar_28;
					  highp vec3 tmpvar_29;
					  tmpvar_29 = ((norm1_23 + norm2_22) * 0.5);
					  highp vec2 tmpvar_30;
					  tmpvar_30.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_31;
					  tmpvar_31 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_30.y = (xlv_TEXCOORD0.w + tmpvar_31);
					  highp vec2 tmpvar_32;
					  tmpvar_32.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_32.y = (xlv_TEXCOORD0.w + (tmpvar_31 * 0.5));
					  fc_21 = ((texture2D (_SplashTex, tmpvar_30) + texture2D (_SplashTex, tmpvar_32)) * 0.5);
					  highp vec4 tmpvar_33;
					  tmpvar_33 = ((_Color * (1.0 - tmpvar_10.x)) + (tmpvar_10.x * fc_21));
					  c_20 = tmpvar_33;
					  tmpvar_18 = (1.0 - tmpvar_10.x);
					  tmpvar_17 = (_Shininess * (1.0 - tmpvar_10.x));
					  tmpvar_16 = tmpvar_29;
					  mediump vec3 tmpvar_34;
					  tmpvar_34.x = dot (tmpvar_11, tmpvar_16);
					  tmpvar_34.y = dot (tmpvar_12, tmpvar_16);
					  tmpvar_34.z = dot (tmpvar_13, tmpvar_16);
					  highp vec3 tmpvar_35;
					  tmpvar_35 = (tmpvar_9 - (2.0 * (
					    dot (tmpvar_34, tmpvar_9)
					   * tmpvar_34)));
					  tmpvar_19 = (((
					    ((textureCube (_Cube, tmpvar_35).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_10.x)
					  ) + (tmpvar_10.x * fc_21.w)) * tmpvar_10.w);
					  highp vec4 tmpvar_36;
					  tmpvar_36.w = 1.0;
					  tmpvar_36.xyz = xlv_TEXCOORD4;
					  lightCoord_6 = (unity_WorldToLight * tmpvar_36);
					  lowp vec4 tmpvar_37;
					  highp vec2 P_38;
					  P_38 = ((lightCoord_6.xy / lightCoord_6.w) + 0.5);
					  tmpvar_37 = texture2D (_LightTexture0, P_38);
					  highp float tmpvar_39;
					  tmpvar_39 = dot (lightCoord_6.xyz, lightCoord_6.xyz);
					  lowp vec4 tmpvar_40;
					  tmpvar_40 = texture2D (_LightTextureB0, vec2(tmpvar_39));
					  highp float tmpvar_41;
					  tmpvar_41 = ((float(
					    (lightCoord_6.z > 0.0)
					  ) * tmpvar_37.w) * tmpvar_40.w);
					  atten_5 = tmpvar_41;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_16);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_16);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_16);
					  lowp vec3 tmpvar_42;
					  tmpvar_42 = normalize(worldN_3);
					  worldN_3 = tmpvar_42;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_8;
					  tmpvar_1 = (tmpvar_1 * atten_5);
					  mediump vec3 viewDir_43;
					  viewDir_43 = worldViewDir_7;
					  lowp vec4 c_44;
					  lowp vec4 c_45;
					  highp float nh_46;
					  lowp float diff_47;
					  mediump float tmpvar_48;
					  tmpvar_48 = max (0.0, dot (tmpvar_42, tmpvar_2));
					  diff_47 = tmpvar_48;
					  mediump float tmpvar_49;
					  tmpvar_49 = max (0.0, dot (tmpvar_42, normalize(
					    (tmpvar_2 + viewDir_43)
					  )));
					  nh_46 = tmpvar_49;
					  mediump float y_50;
					  y_50 = (tmpvar_17 * 128.0);
					  highp float tmpvar_51;
					  tmpvar_51 = (pow (nh_46, y_50) * tmpvar_18);
					  c_45.xyz = (((c_20.xyz * tmpvar_1) * diff_47) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_51));
					  c_45.w = tmpvar_19;
					  c_44.w = c_45.w;
					  c_44.xyz = c_45.xyz;
					  c_4.w = c_44.w;
					  highp float tmpvar_52;
					  tmpvar_52 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_45.xyz * vec3(tmpvar_52));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec3 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xyz;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (lightCoord_5, lightCoord_5);
					  lowp float tmpvar_37;
					  tmpvar_37 = (texture2D (_LightTextureB0, vec2(tmpvar_36)).w * textureCube (_LightTexture0, lightCoord_5).w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_38;
					  tmpvar_38 = normalize(worldN_3);
					  worldN_3 = tmpvar_38;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_37);
					  mediump vec3 viewDir_39;
					  viewDir_39 = worldViewDir_6;
					  lowp vec4 c_40;
					  lowp vec4 c_41;
					  highp float nh_42;
					  lowp float diff_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_38, tmpvar_2));
					  diff_43 = tmpvar_44;
					  mediump float tmpvar_45;
					  tmpvar_45 = max (0.0, dot (tmpvar_38, normalize(
					    (tmpvar_2 + viewDir_39)
					  )));
					  nh_42 = tmpvar_45;
					  mediump float y_46;
					  y_46 = (tmpvar_16 * 128.0);
					  highp float tmpvar_47;
					  tmpvar_47 = (pow (nh_42, y_46) * tmpvar_17);
					  c_41.xyz = (((c_19.xyz * tmpvar_1) * diff_43) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_47));
					  c_41.w = tmpvar_18;
					  c_40.w = c_41.w;
					  c_40.xyz = c_41.xyz;
					  c_4.w = c_40.w;
					  highp float tmpvar_48;
					  tmpvar_48 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_41.xyz * vec3(tmpvar_48));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec3 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xyz;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (lightCoord_5, lightCoord_5);
					  lowp float tmpvar_37;
					  tmpvar_37 = (texture2D (_LightTextureB0, vec2(tmpvar_36)).w * textureCube (_LightTexture0, lightCoord_5).w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_38;
					  tmpvar_38 = normalize(worldN_3);
					  worldN_3 = tmpvar_38;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_37);
					  mediump vec3 viewDir_39;
					  viewDir_39 = worldViewDir_6;
					  lowp vec4 c_40;
					  lowp vec4 c_41;
					  highp float nh_42;
					  lowp float diff_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_38, tmpvar_2));
					  diff_43 = tmpvar_44;
					  mediump float tmpvar_45;
					  tmpvar_45 = max (0.0, dot (tmpvar_38, normalize(
					    (tmpvar_2 + viewDir_39)
					  )));
					  nh_42 = tmpvar_45;
					  mediump float y_46;
					  y_46 = (tmpvar_16 * 128.0);
					  highp float tmpvar_47;
					  tmpvar_47 = (pow (nh_42, y_46) * tmpvar_17);
					  c_41.xyz = (((c_19.xyz * tmpvar_1) * diff_43) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_47));
					  c_41.w = tmpvar_18;
					  c_40.w = c_41.w;
					  c_40.xyz = c_41.xyz;
					  c_4.w = c_40.w;
					  highp float tmpvar_48;
					  tmpvar_48 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_41.xyz * vec3(tmpvar_48));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform highp vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform lowp samplerCube _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _LightTextureB0;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec3 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  highp vec3 tmpvar_13;
					  tmpvar_13 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xyz;
					  highp float tmpvar_36;
					  tmpvar_36 = dot (lightCoord_5, lightCoord_5);
					  lowp float tmpvar_37;
					  tmpvar_37 = (texture2D (_LightTextureB0, vec2(tmpvar_36)).w * textureCube (_LightTexture0, lightCoord_5).w);
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_38;
					  tmpvar_38 = normalize(worldN_3);
					  worldN_3 = tmpvar_38;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_37);
					  mediump vec3 viewDir_39;
					  viewDir_39 = worldViewDir_6;
					  lowp vec4 c_40;
					  lowp vec4 c_41;
					  highp float nh_42;
					  lowp float diff_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_38, tmpvar_2));
					  diff_43 = tmpvar_44;
					  mediump float tmpvar_45;
					  tmpvar_45 = max (0.0, dot (tmpvar_38, normalize(
					    (tmpvar_2 + viewDir_39)
					  )));
					  nh_42 = tmpvar_45;
					  mediump float y_46;
					  y_46 = (tmpvar_16 * 128.0);
					  highp float tmpvar_47;
					  tmpvar_47 = (pow (nh_42, y_46) * tmpvar_17);
					  c_41.xyz = (((c_19.xyz * tmpvar_1) * diff_43) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_47));
					  c_41.w = tmpvar_18;
					  c_40.w = c_41.w;
					  c_40.xyz = c_41.xyz;
					  c_4.w = c_40.w;
					  highp float tmpvar_48;
					  tmpvar_48 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_41.xyz * vec3(tmpvar_48));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec2 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xy;
					  lowp float tmpvar_36;
					  tmpvar_36 = texture2D (_LightTexture0, lightCoord_5).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_6;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_16 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_17);
					  c_40.xyz = (((c_19.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_18;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  c_4.w = c_39.w;
					  highp float tmpvar_47;
					  tmpvar_47 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_40.xyz * vec3(tmpvar_47));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec2 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xy;
					  lowp float tmpvar_36;
					  tmpvar_36 = texture2D (_LightTexture0, lightCoord_5).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_6;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_16 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_17);
					  c_40.xyz = (((c_19.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_18;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  c_4.w = c_39.w;
					  highp float tmpvar_47;
					  tmpvar_47 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_40.xyz * vec3(tmpvar_47));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = 1.0;
					  tmpvar_7.xyz = tmpvar_5.xyz;
					  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  lowp vec3 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  lowp vec3 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  lowp vec3 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  gl_Position = tmpvar_6;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_TEXCOORD4 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD5 = ((tmpvar_6.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform mediump vec4 _WorldSpaceLightPos0;
					uniform lowp vec4 _LightColor0;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _LightTexture0;
					uniform highp mat4 unity_WorldToLight;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Shininess;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying lowp vec3 xlv_TEXCOORD1;
					varying lowp vec3 xlv_TEXCOORD2;
					varying lowp vec3 xlv_TEXCOORD3;
					varying highp vec3 xlv_TEXCOORD4;
					varying lowp vec4 xlv_COLOR0;
					varying highp float xlv_TEXCOORD5;
					void main ()
					{
					  mediump vec3 tmpvar_1;
					  mediump vec3 tmpvar_2;
					  lowp vec3 worldN_3;
					  lowp vec4 c_4;
					  highp vec2 lightCoord_5;
					  lowp vec3 worldViewDir_6;
					  lowp vec3 lightDir_7;
					  highp vec3 tmpvar_8;
					  highp vec4 tmpvar_9;
					  mediump vec3 tmpvar_10;
					  mediump vec3 tmpvar_11;
					  mediump vec3 tmpvar_12;
					  mediump vec3 tmpvar_13;
					  tmpvar_13 = _WorldSpaceLightPos0.xyz;
					  lightDir_7 = tmpvar_13;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
					  worldViewDir_6 = tmpvar_14;
					  tmpvar_8 = -(worldViewDir_6);
					  tmpvar_10 = xlv_TEXCOORD1;
					  tmpvar_11 = xlv_TEXCOORD2;
					  tmpvar_12 = xlv_TEXCOORD3;
					  tmpvar_9 = xlv_COLOR0;
					  lowp vec3 tmpvar_15;
					  mediump float tmpvar_16;
					  lowp float tmpvar_17;
					  lowp float tmpvar_18;
					  lowp vec4 c_19;
					  lowp vec4 fc_20;
					  highp vec3 norm2_21;
					  highp vec3 norm1_22;
					  highp float tmpvar_23;
					  tmpvar_23 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_24;
					  tmpvar_24 = (xlv_TEXCOORD0.xy + vec2(tmpvar_23));
					  highp vec2 tmpvar_25;
					  tmpvar_25.x = (xlv_TEXCOORD0.x - tmpvar_23);
					  tmpvar_25.y = ((xlv_TEXCOORD0.y + tmpvar_23) + 0.5);
					  lowp vec3 tmpvar_26;
					  tmpvar_26 = ((texture2D (_BumpMap, tmpvar_24).xyz * 2.0) - 1.0);
					  norm1_22 = tmpvar_26;
					  lowp vec3 tmpvar_27;
					  tmpvar_27 = ((texture2D (_BumpMap, tmpvar_25).xyz * 2.0) - 1.0);
					  norm2_21 = tmpvar_27;
					  highp vec3 tmpvar_28;
					  tmpvar_28 = ((norm1_22 + norm2_21) * 0.5);
					  highp vec2 tmpvar_29;
					  tmpvar_29.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_30;
					  tmpvar_30 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_29.y = (xlv_TEXCOORD0.w + tmpvar_30);
					  highp vec2 tmpvar_31;
					  tmpvar_31.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_31.y = (xlv_TEXCOORD0.w + (tmpvar_30 * 0.5));
					  fc_20 = ((texture2D (_SplashTex, tmpvar_29) + texture2D (_SplashTex, tmpvar_31)) * 0.5);
					  highp vec4 tmpvar_32;
					  tmpvar_32 = ((_Color * (1.0 - tmpvar_9.x)) + (tmpvar_9.x * fc_20));
					  c_19 = tmpvar_32;
					  tmpvar_17 = (1.0 - tmpvar_9.x);
					  tmpvar_16 = (_Shininess * (1.0 - tmpvar_9.x));
					  tmpvar_15 = tmpvar_28;
					  mediump vec3 tmpvar_33;
					  tmpvar_33.x = dot (tmpvar_10, tmpvar_15);
					  tmpvar_33.y = dot (tmpvar_11, tmpvar_15);
					  tmpvar_33.z = dot (tmpvar_12, tmpvar_15);
					  highp vec3 tmpvar_34;
					  tmpvar_34 = (tmpvar_8 - (2.0 * (
					    dot (tmpvar_33, tmpvar_8)
					   * tmpvar_33)));
					  tmpvar_18 = (((
					    ((textureCube (_Cube, tmpvar_34).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_9.x)
					  ) + (tmpvar_9.x * fc_20.w)) * tmpvar_9.w);
					  highp vec4 tmpvar_35;
					  tmpvar_35.w = 1.0;
					  tmpvar_35.xyz = xlv_TEXCOORD4;
					  lightCoord_5 = (unity_WorldToLight * tmpvar_35).xy;
					  lowp float tmpvar_36;
					  tmpvar_36 = texture2D (_LightTexture0, lightCoord_5).w;
					  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_15);
					  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_15);
					  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_15);
					  lowp vec3 tmpvar_37;
					  tmpvar_37 = normalize(worldN_3);
					  worldN_3 = tmpvar_37;
					  tmpvar_1 = _LightColor0.xyz;
					  tmpvar_2 = lightDir_7;
					  tmpvar_1 = (tmpvar_1 * tmpvar_36);
					  mediump vec3 viewDir_38;
					  viewDir_38 = worldViewDir_6;
					  lowp vec4 c_39;
					  lowp vec4 c_40;
					  highp float nh_41;
					  lowp float diff_42;
					  mediump float tmpvar_43;
					  tmpvar_43 = max (0.0, dot (tmpvar_37, tmpvar_2));
					  diff_42 = tmpvar_43;
					  mediump float tmpvar_44;
					  tmpvar_44 = max (0.0, dot (tmpvar_37, normalize(
					    (tmpvar_2 + viewDir_38)
					  )));
					  nh_41 = tmpvar_44;
					  mediump float y_45;
					  y_45 = (tmpvar_16 * 128.0);
					  highp float tmpvar_46;
					  tmpvar_46 = (pow (nh_41, y_45) * tmpvar_17);
					  c_40.xyz = (((c_19.xyz * tmpvar_1) * diff_42) + ((tmpvar_1 * _SpecColor.xyz) * tmpvar_46));
					  c_40.w = tmpvar_18;
					  c_39.w = c_40.w;
					  c_39.xyz = c_40.xyz;
					  c_4.w = c_39.w;
					  highp float tmpvar_47;
					  tmpvar_47 = clamp (xlv_TEXCOORD5, 0.0, 1.0);
					  c_4.xyz = (c_40.xyz * vec3(tmpvar_47));
					  gl_FragData[0] = c_4;
					}
					
					
					#endif"
				}
			}
			Program "fp" {
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "SPOT" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "POINT_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_LINEAR" }
					"!!GLES"
				}
			}
		}
		Pass {
			Name "PREPASS"
			LOD 400
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "PREPASSBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 148227
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  lowp vec3 worldViewDir_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  highp vec3 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD1.w;
					  tmpvar_9.y = xlv_TEXCOORD2.w;
					  tmpvar_9.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
					  worldViewDir_3 = tmpvar_10;
					  tmpvar_4 = -(worldViewDir_3);
					  tmpvar_6 = xlv_TEXCOORD1.xyz;
					  tmpvar_7 = xlv_TEXCOORD2.xyz;
					  tmpvar_8 = xlv_TEXCOORD3.xyz;
					  tmpvar_5 = xlv_COLOR0;
					  lowp vec3 tmpvar_11;
					  lowp float tmpvar_12;
					  highp vec3 norm2_13;
					  highp vec3 norm1_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_16;
					  tmpvar_16 = (xlv_TEXCOORD0.xy + vec2(tmpvar_15));
					  highp vec2 tmpvar_17;
					  tmpvar_17.x = (xlv_TEXCOORD0.x - tmpvar_15);
					  tmpvar_17.y = ((xlv_TEXCOORD0.y + tmpvar_15) + 0.5);
					  lowp vec3 tmpvar_18;
					  tmpvar_18 = ((texture2D (_BumpMap, tmpvar_16).xyz * 2.0) - 1.0);
					  norm1_14 = tmpvar_18;
					  lowp vec3 tmpvar_19;
					  tmpvar_19 = ((texture2D (_BumpMap, tmpvar_17).xyz * 2.0) - 1.0);
					  norm2_13 = tmpvar_19;
					  highp vec3 tmpvar_20;
					  tmpvar_20 = ((norm1_14 + norm2_13) * 0.5);
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_21.y = (xlv_TEXCOORD0.w + tmpvar_22);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_23.y = (xlv_TEXCOORD0.w + (tmpvar_22 * 0.5));
					  tmpvar_11 = tmpvar_20;
					  mediump vec3 tmpvar_24;
					  tmpvar_24.x = dot (tmpvar_6, tmpvar_11);
					  tmpvar_24.y = dot (tmpvar_7, tmpvar_11);
					  tmpvar_24.z = dot (tmpvar_8, tmpvar_11);
					  highp vec3 tmpvar_25;
					  tmpvar_25 = (tmpvar_4 - (2.0 * (
					    dot (tmpvar_24, tmpvar_4)
					   * tmpvar_24)));
					  tmpvar_12 = (((
					    ((textureCube (_Cube, tmpvar_25).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_5.x)
					  ) + (tmpvar_5.x * 
					    ((texture2D (_SplashTex, tmpvar_21) + texture2D (_SplashTex, tmpvar_23)) * 0.5)
					  .w)) * tmpvar_5.w);
					  highp float tmpvar_26;
					  tmpvar_26 = dot (xlv_TEXCOORD1.xyz, tmpvar_11);
					  worldN_2.x = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (xlv_TEXCOORD2.xyz, tmpvar_11);
					  worldN_2.y = tmpvar_27;
					  highp float tmpvar_28;
					  tmpvar_28 = dot (xlv_TEXCOORD3.xyz, tmpvar_11);
					  worldN_2.z = tmpvar_28;
					  lowp vec3 tmpvar_29;
					  tmpvar_29 = normalize(worldN_2);
					  worldN_2 = tmpvar_29;
					  res_1.xyz = ((tmpvar_29 * 0.5) + 0.5);
					  res_1.w = tmpvar_12;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  lowp vec3 worldViewDir_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  highp vec3 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD1.w;
					  tmpvar_9.y = xlv_TEXCOORD2.w;
					  tmpvar_9.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
					  worldViewDir_3 = tmpvar_10;
					  tmpvar_4 = -(worldViewDir_3);
					  tmpvar_6 = xlv_TEXCOORD1.xyz;
					  tmpvar_7 = xlv_TEXCOORD2.xyz;
					  tmpvar_8 = xlv_TEXCOORD3.xyz;
					  tmpvar_5 = xlv_COLOR0;
					  lowp vec3 tmpvar_11;
					  lowp float tmpvar_12;
					  highp vec3 norm2_13;
					  highp vec3 norm1_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_16;
					  tmpvar_16 = (xlv_TEXCOORD0.xy + vec2(tmpvar_15));
					  highp vec2 tmpvar_17;
					  tmpvar_17.x = (xlv_TEXCOORD0.x - tmpvar_15);
					  tmpvar_17.y = ((xlv_TEXCOORD0.y + tmpvar_15) + 0.5);
					  lowp vec3 tmpvar_18;
					  tmpvar_18 = ((texture2D (_BumpMap, tmpvar_16).xyz * 2.0) - 1.0);
					  norm1_14 = tmpvar_18;
					  lowp vec3 tmpvar_19;
					  tmpvar_19 = ((texture2D (_BumpMap, tmpvar_17).xyz * 2.0) - 1.0);
					  norm2_13 = tmpvar_19;
					  highp vec3 tmpvar_20;
					  tmpvar_20 = ((norm1_14 + norm2_13) * 0.5);
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_21.y = (xlv_TEXCOORD0.w + tmpvar_22);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_23.y = (xlv_TEXCOORD0.w + (tmpvar_22 * 0.5));
					  tmpvar_11 = tmpvar_20;
					  mediump vec3 tmpvar_24;
					  tmpvar_24.x = dot (tmpvar_6, tmpvar_11);
					  tmpvar_24.y = dot (tmpvar_7, tmpvar_11);
					  tmpvar_24.z = dot (tmpvar_8, tmpvar_11);
					  highp vec3 tmpvar_25;
					  tmpvar_25 = (tmpvar_4 - (2.0 * (
					    dot (tmpvar_24, tmpvar_4)
					   * tmpvar_24)));
					  tmpvar_12 = (((
					    ((textureCube (_Cube, tmpvar_25).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_5.x)
					  ) + (tmpvar_5.x * 
					    ((texture2D (_SplashTex, tmpvar_21) + texture2D (_SplashTex, tmpvar_23)) * 0.5)
					  .w)) * tmpvar_5.w);
					  highp float tmpvar_26;
					  tmpvar_26 = dot (xlv_TEXCOORD1.xyz, tmpvar_11);
					  worldN_2.x = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (xlv_TEXCOORD2.xyz, tmpvar_11);
					  worldN_2.y = tmpvar_27;
					  highp float tmpvar_28;
					  tmpvar_28 = dot (xlv_TEXCOORD3.xyz, tmpvar_11);
					  worldN_2.z = tmpvar_28;
					  lowp vec3 tmpvar_29;
					  tmpvar_29 = normalize(worldN_2);
					  worldN_2 = tmpvar_29;
					  res_1.xyz = ((tmpvar_29 * 0.5) + 0.5);
					  res_1.w = tmpvar_12;
					  gl_FragData[0] = res_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  tmpvar_5.w = _glesVertex.w;
					  tmpvar_5.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_6;
					  tmpvar_6.w = 1.0;
					  tmpvar_6.xyz = tmpvar_5.xyz;
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_7;
					  tmpvar_7 = (unity_ObjectToWorld * tmpvar_5).xyz;
					  highp mat3 tmpvar_8;
					  tmpvar_8[0] = unity_WorldToObject[0].xyz;
					  tmpvar_8[1] = unity_WorldToObject[1].xyz;
					  tmpvar_8[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_9;
					  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
					  worldNormal_3 = tmpvar_9;
					  highp mat3 tmpvar_10;
					  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((tmpvar_10 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_11;
					  highp float tmpvar_12;
					  tmpvar_12 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_12;
					  lowp vec3 tmpvar_13;
					  tmpvar_13 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_14;
					  tmpvar_14.x = worldTangent_2.x;
					  tmpvar_14.y = tmpvar_13.x;
					  tmpvar_14.z = worldNormal_3.x;
					  tmpvar_14.w = tmpvar_7.x;
					  highp vec4 tmpvar_15;
					  tmpvar_15.x = worldTangent_2.y;
					  tmpvar_15.y = tmpvar_13.y;
					  tmpvar_15.z = worldNormal_3.y;
					  tmpvar_15.w = tmpvar_7.y;
					  highp vec4 tmpvar_16;
					  tmpvar_16.x = worldTangent_2.z;
					  tmpvar_16.y = tmpvar_13.z;
					  tmpvar_16.z = worldNormal_3.z;
					  tmpvar_16.w = tmpvar_7.z;
					  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_14;
					  xlv_TEXCOORD2 = tmpvar_15;
					  xlv_TEXCOORD3 = tmpvar_16;
					  xlv_COLOR0 = _glesColor;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					void main ()
					{
					  lowp vec4 res_1;
					  lowp vec3 worldN_2;
					  lowp vec3 worldViewDir_3;
					  highp vec3 tmpvar_4;
					  highp vec4 tmpvar_5;
					  mediump vec3 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  highp vec3 tmpvar_9;
					  tmpvar_9.x = xlv_TEXCOORD1.w;
					  tmpvar_9.y = xlv_TEXCOORD2.w;
					  tmpvar_9.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_10;
					  tmpvar_10 = normalize((_WorldSpaceCameraPos - tmpvar_9));
					  worldViewDir_3 = tmpvar_10;
					  tmpvar_4 = -(worldViewDir_3);
					  tmpvar_6 = xlv_TEXCOORD1.xyz;
					  tmpvar_7 = xlv_TEXCOORD2.xyz;
					  tmpvar_8 = xlv_TEXCOORD3.xyz;
					  tmpvar_5 = xlv_COLOR0;
					  lowp vec3 tmpvar_11;
					  lowp float tmpvar_12;
					  highp vec3 norm2_13;
					  highp vec3 norm1_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_16;
					  tmpvar_16 = (xlv_TEXCOORD0.xy + vec2(tmpvar_15));
					  highp vec2 tmpvar_17;
					  tmpvar_17.x = (xlv_TEXCOORD0.x - tmpvar_15);
					  tmpvar_17.y = ((xlv_TEXCOORD0.y + tmpvar_15) + 0.5);
					  lowp vec3 tmpvar_18;
					  tmpvar_18 = ((texture2D (_BumpMap, tmpvar_16).xyz * 2.0) - 1.0);
					  norm1_14 = tmpvar_18;
					  lowp vec3 tmpvar_19;
					  tmpvar_19 = ((texture2D (_BumpMap, tmpvar_17).xyz * 2.0) - 1.0);
					  norm2_13 = tmpvar_19;
					  highp vec3 tmpvar_20;
					  tmpvar_20 = ((norm1_14 + norm2_13) * 0.5);
					  highp vec2 tmpvar_21;
					  tmpvar_21.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_22;
					  tmpvar_22 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_21.y = (xlv_TEXCOORD0.w + tmpvar_22);
					  highp vec2 tmpvar_23;
					  tmpvar_23.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_23.y = (xlv_TEXCOORD0.w + (tmpvar_22 * 0.5));
					  tmpvar_11 = tmpvar_20;
					  mediump vec3 tmpvar_24;
					  tmpvar_24.x = dot (tmpvar_6, tmpvar_11);
					  tmpvar_24.y = dot (tmpvar_7, tmpvar_11);
					  tmpvar_24.z = dot (tmpvar_8, tmpvar_11);
					  highp vec3 tmpvar_25;
					  tmpvar_25 = (tmpvar_4 - (2.0 * (
					    dot (tmpvar_24, tmpvar_4)
					   * tmpvar_24)));
					  tmpvar_12 = (((
					    ((textureCube (_Cube, tmpvar_25).w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_5.x)
					  ) + (tmpvar_5.x * 
					    ((texture2D (_SplashTex, tmpvar_21) + texture2D (_SplashTex, tmpvar_23)) * 0.5)
					  .w)) * tmpvar_5.w);
					  highp float tmpvar_26;
					  tmpvar_26 = dot (xlv_TEXCOORD1.xyz, tmpvar_11);
					  worldN_2.x = tmpvar_26;
					  highp float tmpvar_27;
					  tmpvar_27 = dot (xlv_TEXCOORD2.xyz, tmpvar_11);
					  worldN_2.y = tmpvar_27;
					  highp float tmpvar_28;
					  tmpvar_28 = dot (xlv_TEXCOORD3.xyz, tmpvar_11);
					  worldN_2.z = tmpvar_28;
					  lowp vec3 tmpvar_29;
					  tmpvar_29 = normalize(worldN_2);
					  worldN_2 = tmpvar_29;
					  res_1.xyz = ((tmpvar_29 * 0.5) + 0.5);
					  res_1.w = tmpvar_12;
					  gl_FragData[0] = res_1;
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
			}
		}
		Pass {
			Name "PREPASS"
			LOD 400
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "PREPASSFINAL" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 240856
			Program "vp" {
				SubProgram "gles hw_tier00 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  mediump vec4 tmpvar_34;
					  tmpvar_34 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_34.w;
					  light_3.xyz = (tmpvar_34.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_35;
					  lowp float spec_36;
					  mediump float tmpvar_37;
					  tmpvar_37 = (tmpvar_34.w * tmpvar_14);
					  spec_36 = tmpvar_37;
					  c_35.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_36));
					  c_35.w = tmpvar_15;
					  c_2 = c_35;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  mediump vec4 tmpvar_34;
					  tmpvar_34 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_34.w;
					  light_3.xyz = (tmpvar_34.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_35;
					  lowp float spec_36;
					  mediump float tmpvar_37;
					  tmpvar_37 = (tmpvar_34.w * tmpvar_14);
					  spec_36 = tmpvar_37;
					  c_35.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_36));
					  c_35.w = tmpvar_15;
					  c_2 = c_35;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  mediump vec4 tmpvar_34;
					  tmpvar_34 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_34.w;
					  light_3.xyz = (tmpvar_34.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_35;
					  lowp float spec_36;
					  mediump float tmpvar_37;
					  tmpvar_37 = (tmpvar_34.w * tmpvar_14);
					  spec_36 = tmpvar_37;
					  c_35.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_36));
					  c_35.w = tmpvar_15;
					  c_2 = c_35;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_37));
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_37));
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_37));
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_37));
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_37));
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
					  light_3.xyz = (light_3.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_34;
					  lowp float spec_35;
					  mediump float tmpvar_36;
					  tmpvar_36 = (light_3.w * tmpvar_14);
					  spec_35 = tmpvar_36;
					  c_34.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_35));
					  c_34.w = tmpvar_15;
					  c_2 = c_34;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_37;
					  tmpvar_37 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_37));
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  mediump vec4 tmpvar_34;
					  tmpvar_34 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_34.w;
					  light_3.xyz = (tmpvar_34.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_35;
					  lowp float spec_36;
					  mediump float tmpvar_37;
					  tmpvar_37 = (tmpvar_34.w * tmpvar_14);
					  spec_36 = tmpvar_37;
					  c_35.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_36));
					  c_35.w = tmpvar_15;
					  c_2 = c_35;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_38;
					  tmpvar_38 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_38));
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  mediump vec4 tmpvar_34;
					  tmpvar_34 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_34.w;
					  light_3.xyz = (tmpvar_34.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_35;
					  lowp float spec_36;
					  mediump float tmpvar_37;
					  tmpvar_37 = (tmpvar_34.w * tmpvar_14);
					  spec_36 = tmpvar_37;
					  c_35.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_36));
					  c_35.w = tmpvar_15;
					  c_2 = c_35;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_38;
					  tmpvar_38 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_38));
					  tmpvar_1 = c_2;
					  gl_FragData[0] = tmpvar_1;
					}
					
					
					#endif"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES
					#version 100
					
					#ifdef VERTEX
					attribute vec4 _glesTANGENT;
					attribute vec4 _glesVertex;
					attribute vec4 _glesColor;
					attribute vec3 _glesNormal;
					attribute vec4 _glesMultiTexCoord0;
					uniform highp vec4 _Time;
					uniform highp vec4 _ProjectionParams;
					uniform mediump vec4 unity_SHAr;
					uniform mediump vec4 unity_SHAg;
					uniform mediump vec4 unity_SHAb;
					uniform mediump vec4 unity_SHBr;
					uniform mediump vec4 unity_SHBg;
					uniform mediump vec4 unity_SHBb;
					uniform mediump vec4 unity_SHC;
					uniform highp mat4 unity_ObjectToWorld;
					uniform highp mat4 unity_WorldToObject;
					uniform highp vec4 unity_WorldTransformParams;
					uniform highp mat4 unity_MatrixVP;
					uniform highp vec4 unity_FogParams;
					uniform highp vec4 _BumpMap_ST;
					uniform highp vec4 _SplashTex_ST;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec4 xlv_TEXCOORD5;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp float tangentSign_1;
					  lowp vec3 worldTangent_2;
					  lowp vec3 worldNormal_3;
					  highp vec4 tmpvar_4;
					  highp vec4 tmpvar_5;
					  highp vec3 tmpvar_6;
					  highp vec4 tmpvar_7;
					  tmpvar_7.w = _glesVertex.w;
					  tmpvar_7.xyz = (_glesVertex.xyz + ((_glesNormal * 
					    (sin(((_Time.x * 3.145) + (_glesVertex.x * 50.0))) + sin(((_Time.x * 2.947) + (_glesVertex.z * 50.0))))
					  ) * 0.004));
					  highp vec4 tmpvar_8;
					  highp vec4 tmpvar_9;
					  tmpvar_9.w = 1.0;
					  tmpvar_9.xyz = tmpvar_7.xyz;
					  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
					  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
					  tmpvar_4.zw = ((_glesMultiTexCoord0.xy * _SplashTex_ST.xy) + _SplashTex_ST.zw);
					  highp vec3 tmpvar_10;
					  tmpvar_10 = (unity_ObjectToWorld * tmpvar_7).xyz;
					  highp mat3 tmpvar_11;
					  tmpvar_11[0] = unity_WorldToObject[0].xyz;
					  tmpvar_11[1] = unity_WorldToObject[1].xyz;
					  tmpvar_11[2] = unity_WorldToObject[2].xyz;
					  highp vec3 tmpvar_12;
					  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
					  worldNormal_3 = tmpvar_12;
					  highp mat3 tmpvar_13;
					  tmpvar_13[0] = unity_ObjectToWorld[0].xyz;
					  tmpvar_13[1] = unity_ObjectToWorld[1].xyz;
					  tmpvar_13[2] = unity_ObjectToWorld[2].xyz;
					  highp vec3 tmpvar_14;
					  tmpvar_14 = normalize((tmpvar_13 * _glesTANGENT.xyz));
					  worldTangent_2 = tmpvar_14;
					  highp float tmpvar_15;
					  tmpvar_15 = (_glesTANGENT.w * unity_WorldTransformParams.w);
					  tangentSign_1 = tmpvar_15;
					  lowp vec3 tmpvar_16;
					  tmpvar_16 = (((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx)) * tangentSign_1);
					  highp vec4 tmpvar_17;
					  tmpvar_17.x = worldTangent_2.x;
					  tmpvar_17.y = tmpvar_16.x;
					  tmpvar_17.z = worldNormal_3.x;
					  tmpvar_17.w = tmpvar_10.x;
					  highp vec4 tmpvar_18;
					  tmpvar_18.x = worldTangent_2.y;
					  tmpvar_18.y = tmpvar_16.y;
					  tmpvar_18.z = worldNormal_3.y;
					  tmpvar_18.w = tmpvar_10.y;
					  highp vec4 tmpvar_19;
					  tmpvar_19.x = worldTangent_2.z;
					  tmpvar_19.y = tmpvar_16.z;
					  tmpvar_19.z = worldNormal_3.z;
					  tmpvar_19.w = tmpvar_10.z;
					  highp vec4 o_20;
					  highp vec4 tmpvar_21;
					  tmpvar_21 = (tmpvar_8 * 0.5);
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = tmpvar_21.x;
					  tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
					  o_20.xy = (tmpvar_22 + tmpvar_21.w);
					  o_20.zw = tmpvar_8.zw;
					  tmpvar_5.zw = vec2(0.0, 0.0);
					  tmpvar_5.xy = vec2(0.0, 0.0);
					  highp mat3 tmpvar_23;
					  tmpvar_23[0] = unity_WorldToObject[0].xyz;
					  tmpvar_23[1] = unity_WorldToObject[1].xyz;
					  tmpvar_23[2] = unity_WorldToObject[2].xyz;
					  highp vec4 tmpvar_24;
					  tmpvar_24.w = 1.0;
					  tmpvar_24.xyz = normalize((_glesNormal * tmpvar_23));
					  mediump vec4 normal_25;
					  normal_25 = tmpvar_24;
					  mediump vec3 res_26;
					  mediump vec3 x_27;
					  x_27.x = dot (unity_SHAr, normal_25);
					  x_27.y = dot (unity_SHAg, normal_25);
					  x_27.z = dot (unity_SHAb, normal_25);
					  mediump vec3 x1_28;
					  mediump vec4 tmpvar_29;
					  tmpvar_29 = (normal_25.xyzz * normal_25.yzzx);
					  x1_28.x = dot (unity_SHBr, tmpvar_29);
					  x1_28.y = dot (unity_SHBg, tmpvar_29);
					  x1_28.z = dot (unity_SHBb, tmpvar_29);
					  res_26 = (x_27 + (x1_28 + (unity_SHC.xyz * 
					    ((normal_25.x * normal_25.x) - (normal_25.y * normal_25.y))
					  )));
					  mediump vec3 tmpvar_30;
					  tmpvar_30 = max (((1.055 * 
					    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
					  ) - 0.055), vec3(0.0, 0.0, 0.0));
					  res_26 = tmpvar_30;
					  tmpvar_6 = tmpvar_30;
					  gl_Position = tmpvar_8;
					  xlv_TEXCOORD0 = tmpvar_4;
					  xlv_TEXCOORD1 = tmpvar_17;
					  xlv_TEXCOORD2 = tmpvar_18;
					  xlv_TEXCOORD3 = tmpvar_19;
					  xlv_COLOR0 = _glesColor;
					  xlv_TEXCOORD4 = o_20;
					  xlv_TEXCOORD5 = tmpvar_5;
					  xlv_TEXCOORD6 = tmpvar_6;
					  xlv_TEXCOORD7 = ((tmpvar_8.z * unity_FogParams.z) + unity_FogParams.w);
					}
					
					
					#endif
					#ifdef FRAGMENT
					uniform highp vec4 _Time;
					uniform highp vec3 _WorldSpaceCameraPos;
					uniform lowp vec4 unity_FogColor;
					uniform lowp vec4 _SpecColor;
					uniform sampler2D _BumpMap;
					uniform sampler2D _SplashTex;
					uniform lowp samplerCube _Cube;
					uniform lowp vec4 _Color;
					uniform lowp vec4 _ReflectColor;
					uniform highp float _MaxWaterSpeed;
					uniform highp float _WaveSpeed;
					uniform mediump float _Transparency;
					uniform sampler2D _LightBuffer;
					varying highp vec4 xlv_TEXCOORD0;
					varying highp vec4 xlv_TEXCOORD1;
					varying highp vec4 xlv_TEXCOORD2;
					varying highp vec4 xlv_TEXCOORD3;
					varying lowp vec4 xlv_COLOR0;
					varying highp vec4 xlv_TEXCOORD4;
					varying highp vec3 xlv_TEXCOORD6;
					varying highp float xlv_TEXCOORD7;
					void main ()
					{
					  lowp vec4 tmpvar_1;
					  mediump vec4 c_2;
					  mediump vec4 light_3;
					  lowp vec3 worldViewDir_4;
					  highp vec3 tmpvar_5;
					  highp vec4 tmpvar_6;
					  mediump vec3 tmpvar_7;
					  mediump vec3 tmpvar_8;
					  mediump vec3 tmpvar_9;
					  highp vec3 tmpvar_10;
					  tmpvar_10.x = xlv_TEXCOORD1.w;
					  tmpvar_10.y = xlv_TEXCOORD2.w;
					  tmpvar_10.z = xlv_TEXCOORD3.w;
					  highp vec3 tmpvar_11;
					  tmpvar_11 = normalize((_WorldSpaceCameraPos - tmpvar_10));
					  worldViewDir_4 = tmpvar_11;
					  tmpvar_5 = -(worldViewDir_4);
					  tmpvar_7 = xlv_TEXCOORD1.xyz;
					  tmpvar_8 = xlv_TEXCOORD2.xyz;
					  tmpvar_9 = xlv_TEXCOORD3.xyz;
					  tmpvar_6 = xlv_COLOR0;
					  lowp vec3 tmpvar_12;
					  lowp vec3 tmpvar_13;
					  lowp float tmpvar_14;
					  lowp float tmpvar_15;
					  lowp vec4 c_16;
					  lowp vec4 fc_17;
					  highp vec3 norm2_18;
					  highp vec3 norm1_19;
					  highp float tmpvar_20;
					  tmpvar_20 = (_Time.x * _WaveSpeed);
					  highp vec2 tmpvar_21;
					  tmpvar_21 = (xlv_TEXCOORD0.xy + vec2(tmpvar_20));
					  highp vec2 tmpvar_22;
					  tmpvar_22.x = (xlv_TEXCOORD0.x - tmpvar_20);
					  tmpvar_22.y = ((xlv_TEXCOORD0.y + tmpvar_20) + 0.5);
					  lowp vec3 tmpvar_23;
					  tmpvar_23 = ((texture2D (_BumpMap, tmpvar_21).xyz * 2.0) - 1.0);
					  norm1_19 = tmpvar_23;
					  lowp vec3 tmpvar_24;
					  tmpvar_24 = ((texture2D (_BumpMap, tmpvar_22).xyz * 2.0) - 1.0);
					  norm2_18 = tmpvar_24;
					  highp vec3 tmpvar_25;
					  tmpvar_25 = ((norm1_19 + norm2_18) * 0.5);
					  highp vec2 tmpvar_26;
					  tmpvar_26.x = xlv_TEXCOORD0.z;
					  highp float tmpvar_27;
					  tmpvar_27 = (_Time.x * _MaxWaterSpeed);
					  tmpvar_26.y = (xlv_TEXCOORD0.w + tmpvar_27);
					  highp vec2 tmpvar_28;
					  tmpvar_28.x = (xlv_TEXCOORD0.z + 0.5);
					  tmpvar_28.y = (xlv_TEXCOORD0.w + (tmpvar_27 * 0.5));
					  fc_17 = ((texture2D (_SplashTex, tmpvar_26) + texture2D (_SplashTex, tmpvar_28)) * 0.5);
					  highp vec4 tmpvar_29;
					  tmpvar_29 = ((_Color * (1.0 - tmpvar_6.x)) + (tmpvar_6.x * fc_17));
					  c_16 = tmpvar_29;
					  tmpvar_14 = (1.0 - tmpvar_6.x);
					  tmpvar_12 = tmpvar_25;
					  mediump vec3 tmpvar_30;
					  tmpvar_30.x = dot (tmpvar_7, tmpvar_12);
					  tmpvar_30.y = dot (tmpvar_8, tmpvar_12);
					  tmpvar_30.z = dot (tmpvar_9, tmpvar_12);
					  highp vec3 tmpvar_31;
					  tmpvar_31 = (tmpvar_5 - (2.0 * (
					    dot (tmpvar_30, tmpvar_5)
					   * tmpvar_30)));
					  lowp vec4 tmpvar_32;
					  tmpvar_32 = textureCube (_Cube, tmpvar_31);
					  tmpvar_13 = ((tmpvar_32.xyz * _ReflectColor.xyz) * (1.0 - tmpvar_6.x));
					  tmpvar_15 = (((
					    ((tmpvar_32.w * _ReflectColor.w) + _Transparency)
					   * 
					    (1.0 - tmpvar_6.x)
					  ) + (tmpvar_6.x * fc_17.w)) * tmpvar_6.w);
					  lowp vec4 tmpvar_33;
					  tmpvar_33 = texture2DProj (_LightBuffer, xlv_TEXCOORD4);
					  light_3 = tmpvar_33;
					  mediump vec4 tmpvar_34;
					  tmpvar_34 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
					  light_3.w = tmpvar_34.w;
					  light_3.xyz = (tmpvar_34.xyz + xlv_TEXCOORD6);
					  lowp vec4 c_35;
					  lowp float spec_36;
					  mediump float tmpvar_37;
					  tmpvar_37 = (tmpvar_34.w * tmpvar_14);
					  spec_36 = tmpvar_37;
					  c_35.xyz = ((c_16.xyz * light_3.xyz) + ((light_3.xyz * _SpecColor.xyz) * spec_36));
					  c_35.w = tmpvar_15;
					  c_2 = c_35;
					  c_2.xyz = (c_2.xyz + tmpvar_13);
					  highp float tmpvar_38;
					  tmpvar_38 = clamp (xlv_TEXCOORD7, 0.0, 1.0);
					  c_2.xyz = mix (unity_FogColor.xyz, c_2.xyz, vec3(tmpvar_38));
					  tmpvar_1 = c_2;
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
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
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
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" }
					"!!GLES"
				}
				SubProgram "gles hw_tier00 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier01 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES"
				}
				SubProgram "gles hw_tier02 " {
					Keywords { "LIGHTPROBE_SH" "FOG_LINEAR" "UNITY_HDR_ON" }
					"!!GLES"
				}
			}
		}
	}
	Fallback "Custom/RunningWaterSimple"
}
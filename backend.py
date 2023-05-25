from fastapi import FastAPI
from fastapi.responses import JSONResponse
from sklearn.preprocessing import MinMaxScaler
import mysql.connector
import requests

from pydantic import BaseModel
import pickle

from typing import List
from typing import Dict, Any, Optional
from fastapi import Query

import pandas as pd
import numpy as np
import json
import re

# Creo una instancia de FastApi
app = FastAPI()

# Importación de los modelos 
with open('kmode.pkl','rb') as km:
    kmode= pickle.load(km)
    
with open('filtrado.pkl','rb') as f:
    model= pickle.load(f)

# Prueba del servidor
@app.get("/")
async def root():
    return {"message": "Hola mundo"}

# MODELO 1--------------------------------------------------------------------------------

# FUNCIONES MODELO 1 (PYTHON)

# 1. Pasar fechas input al formato de los datos

def combinar_edad(anios, meses):
    anios_str = str(anios) + " año" + ("s" if anios != '1' else "")
    meses_str = str(meses) + " mes" + ("es" if meses != '1' else "")
    
    if anios != 0 and meses != 0:
        return anios_str + " y " + meses_str
    elif anios != 0:
        return anios_str
    elif meses != 0:
        return meses_str
    else:
        return "0 meses"  # Si ambos son cero, retorna "0 meses"

# 2. Parseo fechas

def parse_age(age_str):
    match = re.search(r'(\d+) años? (y (\d+) meses?)?', age_str)
    if match:
        years_str = match.group(1)
        years = int(years_str) if years_str else 0
        months_str = match.group(3)
        months = int(months_str) if months_str else 0
        total_months = years * 12 + months
        return total_months / 12
    else:
        return None



# FUNCION MODELO 1 (FASTAPI)

@app.get("/recogerdatos1/")
def recoger_datos(especie: str, raza: str, sexo: str, tamano: str, microchip: str, years_tiempo: str, months_tiempo: str, years_edad: str, months_edad: str):
    
    # Carga de los dataframes que se van a utilizar
    dataframe= pd.read_csv("./poblacion_adoptados_v3.csv")
    centros= pd.read_csv("./poblacion_centros_v3.csv")  
    
    # Conversion de fechas input a formato de los datos
    tiempo_combinado= combinar_edad(years_tiempo, months_tiempo)
    años_combinado= combinar_edad(years_edad, months_edad)
    
    # Diccionario datos input
    user_input = {'id_animal':str(len(dataframe) + 1), 'id_centro':'', 'Raza':raza,
                  'Especie':especie,'Sexo': sexo,'Tamaño':tamano,
                  'Microchip':bool(microchip), 'Tiempo':tiempo_combinado,
                  'Edad':años_combinado}
    
    # Añadir input a dataframe en la ultima posicion
    dataframe_completo = dataframe.append(user_input, ignore_index=True)

    # Parseo de fechas de todo el dataframe
    dataframe_completo['Tiempo_parseado'] = dataframe_completo['Tiempo'].apply(parse_age)
    dataframe_completo['Edad_parseado'] = dataframe_completo['Edad'].apply(parse_age)
    
    # Seleccion de las columnas de entrada al modelo
    dataframe_modelo= dataframe_completo[['Raza', 'Especie', 'Sexo', 'Tamaño',
                                          'Microchip', 'Tiempo_parseado', 'Edad_parseado']]

    # Algoritmo
    clusters= kmode.fit_predict(dataframe_modelo)

    # Añadir la columna de los clusters al dataframe con todas las variables
    dataframe_completo.insert(0, "Cluster", clusters , True)
    
    # ¿A qué cluster pertenece la última fila del dataframe?
    numCluster= dataframe_completo.iloc[-1]['Cluster']

    # Borrar la última fila del dataframe (input) para trabajar con el resto de datos
    dataframe_completo= dataframe_completo[:-1]
    
    # De los datos iniciales, ¿Cuales pertenecen al mismo cluster que el input?
    mascara = dataframe_completo.loc[:, 'Cluster'] == numCluster
    mismoCluster= dataframe_completo[mascara]

    # Del mismo cluster, ¿Qué número de registros hay para cada centro?
    frecuencia_serie= mismoCluster.groupby('id_centro').size()
    sorted_serie = frecuencia_serie.sort_values(ascending= False)  
    sorted_df = pd.DataFrame(sorted_serie, columns=['frecuencia'])
    
    #¿Con qué centro se corresponde cada id? <- ORDENADOS
    df_ok= pd.merge(sorted_df,centros, on= 'id_centro')
    
    # Por si acaso
    df_ok = df_ok.dropna()
    df_ok = df_ok.astype(str)
    
    # Convertir el dataframe a formato JSON
    json_data = df_ok.to_dict(orient="records")
        
    # Devolver los datos en una respuesta JSON
    return JSONResponse(content=json_data)

# MODELO 2--------------------------------------------------------------------------------

# 1. Transformar inputs a puntuaciones

def puntuar(user_input):
    # Inicializo variables en cero:
    cat_abandonado=0
    cat_cariño=0
    cat_cercania=0
    cat_acogida=0
    cat_actividad=0
    cat_dependencia=0
    cat_adaptacion=0
    cat_docil=0
    cat_agradecido=0
    cat_agresivo=0 
    cat_tenso=0 
    cat_alegre=0
    cat_inteligencia=0
    cat_miedo=0 
    cat_convivencia=0 
    cat_correa=0
    cat_carretera=0
    cat_aventura=0 
    cat_niños=0
    cat_belleza=0
    cat_ppp=0
    cat_bruto=0
    cat_triste=0
    cat_tranquilidad=0
    cat_desubicado=0
    cat_recuperacion=0
    cat_cronico=0 
    cat_historial=0
    cat_fortaleza=0
    cat_independencia=0 
    cat_maltrato=0 
    cat_gato=0 
    cat_perro=0
    cat_pelo=0
    cat_macho=0 
    cat_hembra=0 
    cat_ladra=0
    cat_ruido=0
    
    claves_negativos= ['negativo1','negativo2','negativo3','negativo4',
                  'negativo5','negativo6']
    
    valor_negativo= -0.8
    for clave in claves_negativos:
        if user_input[clave] == 'Brutaldad':
            cat_bruto= cat_bruto+valor_negativo
        elif user_input[clave] == 'Tristeza':
            cat_triste= cat_triste+valor_negativo
        elif user_input[clave] == 'Recuperación de enfermedad':
            cat_recuperacion=cat_recuperacion+valor_negativo
        elif user_input[clave] == 'Historial de enfermedades':
            cat_historial=cat_historial+ valor_negativo
            cat_cronico=cat_cronico+ valor_negativo
        elif user_input[clave] == 'Víctima de maltrato':
            cat_maltrato= cat_maltrato+valor_negativo
        elif user_input[clave] == 'Suelta pelo':
            cat_pelo= cat_pelo+valor_negativo

        valor_negativo += 0.2
        valor_negativo = round(valor_negativo, 2)      

    claves_positivos= ['positivo1','positivo2','positivo3','positivo4',
                  'positivo5','positivo6']
    
    valor_positivo= -0.2
    for clave in claves_positivos:
        if user_input[clave] == 'Lealtad':
            cat_docil=cat_docil+valor_positivo
            cat_agradecido=cat_agradecido+valor_positivo
        elif user_input[clave] == 'Alegría':
            cat_alegre=cat_alegre+valor_negativo
        elif user_input[clave] == 'Inteligencia':
            cat_inteligencia=cat_inteligencia+valor_positivo
        elif user_input[clave] == 'Fortaleza': 
            cat_fortaleza=cat_fortaleza+valor_positivo
        elif user_input[clave] == 'Belleza':
            cat_belleza=cat_belleza+valor_positivo
        elif user_input[clave] == 'Capacidad de adaptación':
            cat_adaptacion=cat_adaptacion+valor_positivo

        valor_positivo += 0.2
        valor_positivo = round(valor_positivo, 2)  
        
    if user_input['actividades']== 'si':
        cat_actividad += 0.2
        cat_carretera += -0.2
        cat_desubicado+= -0.2
        cat_aventura +=0.2
        cat_tranquilidad += -0.2

    elif user_input['actividades']== 'no':
        cat_actividad += -0.2
        cat_carretera += 0.2
        cat_desubicado += 0.2
        cat_aventura += -0.2
        cat_tranquilidad += +0.2
 
    if user_input['relaciones']== 'entorno':
        cat_desubicado+= -0.2
        cat_adaptacion += 0.2
        cat_acogida+= 0.2
        cat_convivencia+= 0.2
        cat_cercania+= 0.2
        cat_tenso+= -0.2
        cat_miedo+= -0.2
        cat_ruido+= -0.2

    elif user_input['relaciones']== 'hogar':
        cat_desubicado+= 0.2
        cat_adaptacion+= -0.2
        cat_miedo+= 0.2
        cat_ruido+= 0.2

    if user_input['casa']== 'dia':
        cat_abandonado+=0.2
        cat_dependencia+=0.2
        cat_independencia+= -0.2

    elif user_input['casa']== 'periodos':
        cat_abandonado+= -0.2
        cat_dependencia+= -0.2
        cat_independencia+=0.2
        cat_cercania+=0.2
        
    if user_input['niños']== 'si':
        cat_niños+=0.8
        cat_ruido+= -0.2
   
    elif user_input['niños']== 'no':
        cat_ruido+=0.2
        
    if user_input['patio']== 'si':
        cat_correa+=0.2
    
    elif user_input['patio']== 'no':
        cat_correa+=- 0.2
        cat_ladra+=- 0.6
        
    if user_input['ppp']== 'si':
        cat_ppp+=0.9
    
    elif user_input['ppp']== 'no':
        cat_ppp+=- 0.4
    
    if user_input['cariño']== 'si':
        cat_cariño+= 0.2
        cat_dependencia+= 0.2
        cat_independencia+=-0.2

    elif user_input['cariño']== 'no':
        cat_cariño+= -0.2
        cat_dependencia+= -0.2
        cat_independencia+=0.2
        
    if user_input['animales']== 'si':
        cat_macho+=0.8
        cat_hembra+=0.8
        cat_gato+=0.8
        cat_perro+=0.8
    
    puntuaciones=[cat_abandonado, cat_cariño, cat_cercania, cat_acogida,
       cat_actividad, cat_dependencia, cat_adaptacion, cat_docil,
       cat_agradecido, cat_agresivo, cat_tenso, cat_alegre,
       cat_inteligencia, cat_miedo, cat_convivencia, cat_correa,
       cat_carretera, cat_aventura, cat_niños, cat_belleza, cat_ppp,
       cat_bruto, cat_triste, cat_tranquilidad, cat_desubicado,
       cat_recuperacion, cat_cronico, cat_historial, cat_fortaleza,
       cat_independencia, cat_maltrato, cat_gato, cat_perro,
       cat_pelo, cat_macho, cat_hembra, cat_ladra, cat_ruido]

    return puntuaciones 

#2. Filtra el df con el que se ejecuta el modelo según los inputs

def filtrar_df(user_input):
    df= pd.read_csv("./poblacion_adopcion_v3.csv")
    
    df_cat= df[['cat_abandonado', 'cat_cariño', 'cat_cercania', 'cat_acogida',
       'cat_actividad', 'cat_dependencia', 'cat_adaptacion', 'cat_docil',
       'cat_agradecido', 'cat_agresivo', 'cat_tenso', 'cat_alegre',
       'cat_inteligencia', 'cat_miedo', 'cat_convivencia', 'cat_correa',
       'cat_carretera', 'cat_aventura', 'cat_niños', 'cat_belleza', 'cat_ppp',
       'cat_bruto', 'cat_triste', 'cat_tranquilidad', 'cat_desubicado',
       'cat_recuperacion', 'cat_cronico', 'cat_historial', 'cat_fortaleza',
       'cat_independencia', 'cat_maltrato', 'cat_gato', 'cat_perro',
       'cat_pelo', 'cat_macho', 'cat_hembra', 'cat_ladra', 'cat_ruido']]
    
    if user_input['niños']== 'si':
        df = df.drop(df[df['cat_niños'] < 0].index)
        df = df.drop(df[df['cat_agresivo'] < 0].index)
    
    if user_input['animales']== 'no':
        if user_input['especie']=='Gato':
            df = df.drop(df[df['cat_gato'] < 0].index)
            df = df.drop(df[df['cat_macho'] < 0].index)

        elif user_input['especie']=='Gata':
            df = df.drop(df[df['cat_gato'] < 0].index)
            df = df.drop(df[df['cat_hembra'] < 0].index)

        elif user_input['especie']=='Perro':
            df = df.drop(df[df['cat_perro'] < 0].index)
            df = df.drop(df[df['cat_macho'] < 0].index)

        elif user_input['especie']=='Perra':
            df = df.drop(df[df['cat_perro'] < 0].index)
            df = df.drop(df[df['cat_hembra'] < 0].index)
    
    return df

# FUNCION MODELO 2 (FASTAPI)

@app.get("/recogerdatos2/")
def recoger_datos2(negativo1: Optional[Any], negativo2: Optional[Any], negativo3: Optional[Any], negativo4: Optional[Any], negativo5: Optional[Any], negativo6: Optional[Any], positivo1: Optional[Any], positivo2: Optional[Any], positivo3: Optional[Any], positivo4: Optional[Any],positivo5: Optional[Any],positivo6: Optional[Any], actividades: Optional[Any], relaciones: Optional[Any], casa: Optional[Any], niños: Optional[Any], patio: Optional[Any], ppp: Optional[Any], cariño: Optional[Any], animales: Optional[Any], especie: Optional[Any]):
    
    # Recojo el input en un diccionario
    user_input ={'negativo1': negativo1, 'negativo2': negativo2, 'negativo3': negativo3,'negativo4':negativo4,'negativo5':negativo5,
             'negativo6': negativo6,'positivo1': positivo1, 'positivo2': positivo2, 'positivo3': positivo3, 'positivo4':positivo4,
             'positivo5': positivo5,'positivo6': positivo6, 'actividades': actividades, 'relaciones': relaciones, 'casa': casa, 
             'niños': niños, 'patio': patio, 'ppp': ppp, 'cariño': cariño, 'animales': animales, 'especie': especie}
    
    # df filtrado
    adopcion= filtrar_df(user_input)
    
    # Inicializo el Scaler
    scaler = MinMaxScaler()
    
    puntuacion_usuario= np.array(puntuar(user_input))
    puntuacion_usuario_2d = puntuacion_usuario.reshape(1, -1)
    scaler.fit(puntuacion_usuario_2d) 
    puntuacion_usuario_norm = scaler.transform(puntuacion_usuario_2d)
    
    distancias, indices = model.kneighbors(puntuacion_usuario_norm, n_neighbors=100)

    recomendaciones= adopcion.iloc[indices[0]]
    
    # Por si acaso
    recomendaciones = recomendaciones.fillna(0)
    
    # Convertir el dataframe a formato JSON
    json_data = recomendaciones.to_dict(orient="records")
        
    # Devolver los datos en una respuesta JSON
    return JSONResponse(content=json_data)
    

# DATOS DE CENTROS-------------------------------------------------------------------------

@app.get("/enviarcentros/")
def get_centros():
    # Cargar dataframe
    df= pd.read_csv("./poblacion_centros_v3.csv")

    # ELiminar registros con nulos
    df = df.dropna()
    
    # Convertir el dataframe a formato JSON
    json_data = df.to_dict(orient="records")
    
    # Devolver los datos en una respuesta JSON
    return JSONResponse(content=json_data)
    


# EJECUTAR FASTAPI EN EL SERVIDOR (puerto 8000)--------------------------------------------

if __name__ == "__main__":
    import uvicorn
    # 10.100.25.199 (UNIVERSIDAD)
    # 192.168.8.121 (CASA)
    # 172.20.10.13 (IPHONE)
    uvicorn.run(app, host="192.168.8.121", port=8000)

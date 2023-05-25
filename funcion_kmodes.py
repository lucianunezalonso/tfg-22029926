#!/usr/bin/env python
# coding: utf-8

# # FUNCION PARA EL CLUSTERING

# In[47]:


import pickle
import pandas as pd
import re


# Carga del modelo:

# In[48]:


with open('kmode.pkl','rb') as km:
    kmode= pickle.load(km)


# Carga de los datos de animales:

# In[49]:


adoptados= pd.read_csv("./poblacion_adoptados_v3.csv")


# In[50]:


adoptados.columns


# Carga de los datos de centros:

# In[51]:


centros= pd.read_csv("./poblacion_centros_v3.csv")    


# Ejemplo de entrada de usuario:

# In[52]:


especie= 'Canina'
raza= 'mestizo'
sexo= 'macho'
tamano= 'grande'
microchip= 'false'
years_tiempo= '1'
months_tiempo= '3'
years_edad= '4'
months_edad= '2'


# In[53]:


dataframe= adoptados


# In[54]:


# Juntar meses y años en una variable (mismo formato)

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


# In[55]:


tiempo_combinado= combinar_edad(years_tiempo, months_tiempo)
años_combinado= combinar_edad(years_edad, months_edad)


# In[56]:


dataframe.columns


# In[57]:


user_input = {'id_animal':str(len(dataframe) + 1), 'id_centro':'', 'Raza':raza, 'Especie':especie,'Sexo': sexo,
              'Tamaño':tamano, 'Microchip':bool(microchip), 'Tiempo':tiempo_combinado, 'Edad':años_combinado}


# In[58]:


# Añadir el nuevo registro al final del DataFrame
dataframe_completo = dataframe.append(user_input, ignore_index=True)


# In[59]:


dataframe_completo.tail()


# In[60]:


# Parseo
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


# In[61]:


dataframe_completo['Tiempo_parseado'] = dataframe_completo['Tiempo'].apply(parse_age)
dataframe_completo['Edad_parseado'] = dataframe_completo['Edad'].apply(parse_age)


# In[62]:


# Seleccion de columnas para el modelo
dataframe_modelo= dataframe_completo[['Raza', 'Especie', 'Sexo', 'Tamaño',
                                          'Microchip', 'Tiempo_parseado', 'Edad_parseado']]


# In[63]:


clusters= kmode.fit_predict(dataframe_modelo)


# In[64]:


# Pero la columna la añado al conjunto de datos con la columna id
dataframe_completo.insert(0, "Cluster", clusters , True)


# In[65]:


# ¿A qué cluster pertenece la última fila del dataframe?
numCluster= dataframe_completo.iloc[-1]['Cluster']


# In[66]:


# Borro la última fila del dataframe para trabajar con el resto de datos
dataframe_completo= dataframe_completo[:-1]


# In[67]:


# De los datos iniciales, ¿Cuales pertenecen al mismo cluster?
mascara = dataframe_completo.loc[:, 'Cluster'] == numCluster
mismoCluster= dataframe_completo[mascara]


# In[68]:


# Del mismo cluster, ¿Qué número de registros hay para cada centro?
frecuencia_serie= mismoCluster.groupby('id_centro').size()
sorted_serie = frecuencia_serie.sort_values(ascending= False)  


# In[75]:


sorted_serie


# In[82]:


sorted_df = pd.DataFrame(sorted_serie, columns=['frecuencia'])


# In[84]:


# Me queda ver con que centro se corresponde cada id
df_ok= pd.merge(sorted_df,centros, on= 'id_centro')


# In[85]:


df_ok


# df_ok son los datos ordenados en funcion de las coincidencias, es decir, lo que tengo que visualizar en la aplicación de forma bonita

# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[ ]:





# In[30]:


def funcion(dataframe, user_input):
    # Importo el dataset centros (lo voy a necesitar localmente)
    centros= pd.read_csv("./poblacion_centros_v3.csv")    
    
    # Introduzco el registro proporcionado por el usuario en la última posición
    user_input.append(len(dataframe) + 1)  # Agregar el ID del animal
    dataframe_completo = dataframe + [user_input]  
    
    # Ahora aplico el modelo al df sin las columnas id
    dataframe_modelo= dataframe_completo[['Raza', 'Especie', 'Sexo', 'Tamaño',
                                          'Microchip', 'Tiempo', 'Edad']]
    
    clusters= kmode.fit_predict(dataframe_modelo)
    
    # Pero la columna la añado al conjunto de datos con la columna id
    dataframe_completo.insert(0, "Cluster", clusters , True)
    
    # ¿A qué cluster pertenece la última fila del dataframe?
    numCluster= dataframe_completo.iloc[-1]['Cluster']
    
    # Saco la última fila del dataframe para trabajar con el resto de datos
    dataframe_completo= dataframe_completo[:-1]
    
    # De los datos iniciales, ¿Cuales pertenecen al mismo cluster?
    mascara = dataframe_completo.loc[:, 'Cluster'] == numCluster
    mismoCluster= dataframe_completo[mascara]
    
    # Del mismo cluster, ¿Qué número de registros hay para cada centro?
    frecuencia_serie= mismoCluster.groupby('id_centro').size()
    sorted_serie = frecuencia_serie.sort_values(ascending= False) 
    
    # Selecciono los 5 primeros centros para hacer un top 5
    primeros = sorted_serie.iloc[:5]
    
    # Paso la serie a df y añado una columna "top" (+ algunas transformaciones)
    primeros_df = pd.DataFrame(primeros, columns=['frecuencia'])
    top = [1,2,3,4,5] 
    primeros_df['top'] = top

    primeros_df_ok = pd.DataFrame(primeros_df,index=primeros_df.index).rename_axis('id_centro')
    df_ok= primeros_df_ok.reset_index() # Paso el indice por defecto a columna
    
    # Me queda ver con que centro se corresponde cada id
    top5= pd.merge(df_ok,centros, on= 'id_centro')
    
    #top5= top5.drop(['Unnamed: 0','id_centro', 'frecuencia','descripcion', 'imagen_logo','imagen_fondo', 'google_maps'], axis=1) 
    
    return top5


# In[5]:


centros= pd.read_csv("./poblacion_centros_v3.csv") 


# In[6]:


centros


# Parámetros de usuario:

# In[16]:


adoptados


# In[17]:


Raza= 'Pastor Vasco'
Especie= 'Canina'
Sexo= 'Hembra'
Tamaño= 'Pequeño'
Microchip= False
Tiempo= '2 años y 5 meses'
Edad= '3 años y 4 meses'


# In[20]:


# Parseo de la edad y tiempo

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


# In[22]:


user_input


# In[23]:


user_input = [Raza, Especie, Sexo, Tamaño, Microchip, parse_age(Tiempo), parse_age(Edad)]


# Aplico función a los parámetros del usuario:

# In[31]:


output= funcion(dataframe, user_input)


# In[32]:


centros= pd.read_csv("./poblacion_centros_v3.csv") 


# In[33]:


dataframe= adoptados


# In[34]:


dataframe


# In[35]:


user_input = []


# In[ ]:





# In[ ]:


def funcion(dataframe, user_input):
    # Importo el dataset centros (lo voy a necesitar localmente)
    centros= pd.read_csv("./poblacion_centros_v3.csv")    
    
    # Introduzco el registro proporcionado por el usuario en la última posición
    user_input.append(len(dataframe) + 1)  # Agregar el ID del animal
    dataframe_completo = dataframe + [user_input]  
    
    # Ahora aplico el modelo al df sin las columnas id
    dataframe_modelo= dataframe_completo[['Raza', 'Especie', 'Sexo', 'Tamaño',
                                          'Microchip', 'Tiempo', 'Edad']]
    
    clusters= kmode.fit_predict(dataframe_modelo)
    
    # Pero la columna la añado al conjunto de datos con la columna id
    dataframe_completo.insert(0, "Cluster", clusters , True)
    
    # ¿A qué cluster pertenece la última fila del dataframe?
    numCluster= dataframe_completo.iloc[-1]['Cluster']
    
    # Saco la última fila del dataframe para trabajar con el resto de datos
    dataframe_completo= dataframe_completo[:-1]
    
    # De los datos iniciales, ¿Cuales pertenecen al mismo cluster?
    mascara = dataframe_completo.loc[:, 'Cluster'] == numCluster
    mismoCluster= dataframe_completo[mascara]
    
    # Del mismo cluster, ¿Qué número de registros hay para cada centro?
    frecuencia_serie= mismoCluster.groupby('id_centro').size()
    sorted_serie = frecuencia_serie.sort_values(ascending= False) 
    
    # Selecciono los 5 primeros centros para hacer un top 5
    primeros = sorted_serie.iloc[:5]
    
    # Paso la serie a df y añado una columna "top" (+ algunas transformaciones)
    primeros_df = pd.DataFrame(primeros, columns=['frecuencia'])
    top = [1,2,3,4,5] 
    primeros_df['top'] = top

    primeros_df_ok = pd.DataFrame(primeros_df,index=primeros_df.index).rename_axis('id_centro')
    df_ok= primeros_df_ok.reset_index() # Paso el indice por defecto a columna
    
    # Me queda ver con que centro se corresponde cada id
    top5= pd.merge(df_ok,centros, on= 'id_centro')
    
    #top5= top5.drop(['Unnamed: 0','id_centro', 'frecuencia','descripcion', 'imagen_logo','imagen_fondo', 'google_maps'], axis=1) 
    
    return top5


# In[ ]:





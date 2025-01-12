# Comandos y Argumentos en Kubernetes

Los campos `command` y `args` en Kubernetes permiten personalizar el comportamiento de los contenedores durante su ejecución. Para entenderlo de manera sencilla, pensemos en ejemplos de la vida cotidiana que nos ayuden a comprender estos conceptos.

## ¿Qué son Command y Args?

### Command:
- El campo `command` es como el "trabajo principal" de una persona en un evento. Por ejemplo, si contratas a un chef para cocinar en una fiesta, su "comando" es: **cocinar**.
- En Kubernetes, `command` define qué hará el contenedor cuando se inicie.
- Si no defines `command`, el contenedor hará lo que ya estaba programado en su "receta" original (definido en la imagen Docker).

### Args:
- El campo `args` son como las "indicaciones adicionales" para el chef. Por ejemplo, podrías decirle: **Cocina pasta con salsa roja**. Aquí, la "salsa roja" es el argumento que le das al chef para personalizar su tarea.
- En Kubernetes, `args` son las opciones o entradas adicionales que el contenedor necesita para ejecutar su trabajo.

## Principales diferencias entre Command y Args
- `command` reemplaza el "trabajo principal" que el contenedor iba a hacer originalmente.
- `args` son detalles adicionales que complementan ese trabajo.

## ¿Qué es Docker ENTRYPOINT?
En Docker, `ENTRYPOINT` es como la profesión principal de una persona. Por ejemplo:
- Si una imagen Docker tiene:
  ```dockerfile
  ENTRYPOINT ["nginx"]
  CMD ["-g", "daemon off;"]
  ```
  Es como decir: "Este chef siempre cocinará (nginx), y por defecto, cocinará pasta con salsa roja (-g daemon off;)".
- En Kubernetes, puedes sobrescribir este comportamiento para cambiar lo que hace o cómo lo hace.

### Comportamiento predeterminado:
Si una imagen de contenedor tiene definido:
```dockerfile
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
```
Es como contratar a un chef que, por defecto, siempre cocina pasta con salsa roja.
Cuando inicias el contenedor, hará:
```bash
nginx -g 'daemon off;'
```

### Sobrescribir en Kubernetes:
Puedes cambiar lo que el chef cocina, diciéndole exactamente qué hacer:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  containers:
    - name: example-container
      image: nginx
      command: ["nginx"]
      args: ["-g", "daemon off;"]
```
En este caso:
- `command` le dice al chef que siga siendo un cocinero (nginx).
- `args` le dice que haga pasta con salsa roja (-g daemon off;).

### Reemplazar completamente el comando:
Supongamos que quieres que el chef haga algo totalmente diferente, como dormir 1 hora:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: custom-command-pod
spec:
  containers:
    - name: custom-container
      image: nginx
      command: ["sleep"]
      args: ["3600"]
```
Esto es como decirle al chef: "En lugar de cocinar, duerme por 1 hora (3600 segundos)".
El contenedor ejecutará:
```bash
sleep 3600
```
En lugar de cocinar.

## ¿Por qué son útiles?
1. **Flexibilidad:** Puedes pedirle al chef que cocine algo diferente sin contratar a otro chef (sin reconstruir la imagen Docker).
2. **Configuración en tiempo de ejecución:** Dependiendo de la fiesta (entorno), puedes personalizar las indicaciones.
3. **Pruebas:** Puedes probar diferentes recetas (comportamientos) cambiando solo las instrucciones.

## Cosas a tener en cuenta
1. Si especificas solo `args` y no `command`, los `args` se añaden al trabajo predeterminado del chef (CMD).
2. Si especificas `command`, este reemplaza completamente el trabajo principal del chef (ENTRYPOINT), y el trabajo predeterminado (CMD) será ignorado a menos que lo agregues explícitamente como `args`.

## Resumen
Los campos `command` y `args` en Kubernetes son como dar instrucciones claras y personalizadas a un chef (el contenedor) sobre qué hacer y cómo hacerlo. Te permiten controlar su comportamiento de manera flexible, sin necesidad de modificar su "profesión" (imagen Docker). Conocer estas opciones te ayudará a gestionar y desplegar aplicaciones en Kubernetes de manera agil y sencilla.




create or replace NONEDITIONABLE PACKAGE BODY PKG_LATINOSTRAVEL AS

  PROCEDURE PR_I_PASAJERO(      pPasajeroId         OUT PASAJERO.PASAJERO_ID%TYPE,
                                pPrimerNombre       IN PASAJERO.PRIMERNOMBRE%TYPE,
                                pSegundoNombre      IN PASAJERO.SEGUNDONOMBRE%TYPE,
                                pPrimerApellido     IN PASAJERO.PRIMERAPELLIDO%TYPE,
                                pSegundoApellido    IN PASAJERO.SEGUNDOAPELLIDO%TYPE,
                                pTipoDocumento      IN PASAJERO.TIPO_DOCUMENTO%TYPE,
                                pNumDocumento       IN PASAJERO.NUM_DOCUMENTO%TYPE,                         
                                pFechaNacimiento    IN PASAJERO.FECHANACIMIENTO%TYPE,
                                pPais               IN PASAJERO.PAIS%TYPE,
                                pTelefono           IN PASAJERO.TELEFONO%TYPE,
                                pEmail              IN PASAJERO.EMAIL%TYPE,
                                pClave              IN PASAJERO.CLAVE%TYPE,
                                pRegistro           OUT var_cursor,
                                pResultado          OUT VARCHAR2,
                                pMsgError           OUT VARCHAR2) AS
    objetoActual varchar2(200):='PR_I_PASAJERO';
    cursorLectura var_cursor;
    existePasajero NUMBER(1);
  BEGIN
            SELECT CASE WHEN EXISTS (SELECT PASAJERO_ID FROM PASAJERO
                                      WHERE PASAJERO_ID=pPasajeroId)
            THEN 1
            ELSE 0            
            END INTO existePasajero FROM dual;
            
            IF(existePasajero>0) THEN
                pMsgError:='El pasajero ya existe. Error al guardar.';
            END IF;
            
            IF(existePasajero<1) THEN
            INSERT INTO PASAJERO(PRIMERNOMBRE, 
                                    SEGUNDONOMBRE, 
                                    PRIMERAPELLIDO, 
                                    SEGUNDOAPELLIDO,
                                    TIPO_DOCUMENTO,
                                    NUM_DOCUMENTO,
                                    FECHANACIMIENTO,
                                    PAIS,
                                    TELEFONO,
                                    EMAIL,
                                    CLAVE
                                    )
            VALUES(
                                    pPrimerNombre,
                                    pSegundoNombre,
                                    pPrimerApellido,
                                    pSegundoApellido,
                                    pTipoDocumento,
                                    pNumDocumento,
                                    pFechaNacimiento,
                                    pPais,
                                    pTelefono,
                                    pEmail,
                                    pClave
                                    )
                                
                RETURNING PASAJERO_ID INTO pPasajeroId;
                
                OPEN cursorLectura FOR
                SELECT * FROM PASAJERO WHERE PASAJERO_ID=pPasajeroId;
                
                 pResultado:='EL PASAJERO SE HA CREADO SATISFACTORIAMENTE pPasajeroId:' || pPasajeroId; 
                 
                 pRegistro := cursorLectura;
            END IF;

  END PR_I_PASAJERO;
  
  PROCEDURE PR_U_PASAJERO(      pPasajeroId         IN PASAJERO.PASAJERO_ID%TYPE,
                                pPrimerNombre       IN PASAJERO.PRIMERNOMBRE%TYPE,
                                pSegundoNombre      IN PASAJERO.SEGUNDONOMBRE%TYPE,
                                pPrimerApellido     IN PASAJERO.PRIMERAPELLIDO%TYPE,
                                pSegundoApellido    IN PASAJERO.SEGUNDOAPELLIDO%TYPE,
                                pTipoDocumento      IN PASAJERO.TIPO_DOCUMENTO%TYPE,
                                pNumDocumento       IN PASAJERO.NUM_DOCUMENTO%TYPE,                         
                                pFechaNacimiento    IN PASAJERO.FECHANACIMIENTO%TYPE,
                                pPais               IN PASAJERO.PAIS%TYPE,
                                pTelefono           IN PASAJERO.TELEFONO%TYPE,
                                pEmail              IN PASAJERO.EMAIL%TYPE,
                                pClave              IN PASAJERO.CLAVE%TYPE,
                                pRegistro           OUT var_cursor,
                                pResultado          OUT VARCHAR2,
                                pMsgError           OUT VARCHAR2) AS
    cursorLectura var_cursor;                                
    objetoActual varchar2(200):='PR_U_PASAJERO=>';
  BEGIN      
            IF(pPasajeroId>0) THEN
                UPDATE PASAJERO SET
                    PRIMERNOMBRE= NVL(pPrimerNombre,PRIMERNOMBRE),
                    SEGUNDONOMBRE=NVL(pSegundoNombre,SEGUNDONOMBRE),                  
                    PRIMERAPELLIDO=NVL(pPrimerApellido,PRIMERAPELLIDO),
                    SEGUNDOAPELLIDO=NVL(pSegundoApellido,SEGUNDOAPELLIDO),                 
                    TIPO_DOCUMENTO=NVL(pTipoDocumento,TIPO_DOCUMENTO),
                    NUM_DOCUMENTO=NVL(pNumDocumento,NUM_DOCUMENTO),
                    FECHANACIMIENTO=NVL(pFechaNacimiento,FECHANACIMIENTO),
                    PAIS=NVL(pPais,PAIS),
                    TELEFONO=NVL(pTelefono,TELEFONO),
                    EMAIL=NVL(pEmail,EMAIL),
                    CLAVE=NVL(pClave,CLAVE)
                WHERE PASAJERO_ID=pPasajeroId;

                OPEN cursorLectura FOR
                SELECT * FROM PASAJERO WHERE PASAJERO_ID=pPasajeroId;
                
                pResultado:='EL PASAJERO SE HA ACTUALIZADO SATISFACTORIAMENTE pPasajeroId:' || pPasajeroId; 
                 
                pRegistro := cursorLectura;
            END IF;

  END PR_U_PASAJERO;
  
  PROCEDURE PR_D_PASAJERO(      pPasajeroId         IN PASAJERO.PASAJERO_ID%TYPE,                                
                                pRegistro           OUT var_cursor,
                                pResultado          OUT VARCHAR2,
                                pMsgError           OUT VARCHAR2) AS
    objetoActual varchar2(200):='PR_D_PASAJERO';
    existePaciente NUMBER(1);
  BEGIN      
            IF(pPasajeroId>0) THEN
                UPDATE PASAJERO SET
                    ACTIVO=0
                WHERE PASAJERO_ID=pPasajeroId;

                 pResultado:='EL PASAJERO SE HA ELIMINADO SATISFACTORIAMENTE pPasajeroId:' || pPasajeroId; 
            END IF;

  END PR_D_PASAJERO;

  PROCEDURE PR_R_PASAJERO(      pPasajeroId         IN PASAJERO.PASAJERO_ID%TYPE,
                                pNumDocumento       IN PASAJERO.NUM_DOCUMENTO%TYPE,
                                pRegistro           OUT var_cursor,
                                pResultado          OUT VARCHAR2,
                                pMsgError           OUT VARCHAR2) AS
    objetoActual varchar2(200):='PR_R_PASAJERO';
    cursorLectura var_cursor;
  BEGIN      
            IF(pPasajeroId>0) THEN
                OPEN cursorLectura FOR
                SELECT * FROM PASAJERO WHERE PASAJERO_ID=pPasajeroId;
            END IF;
            IF(LENGTH(pNumDocumento)>0) THEN
                OPEN cursorLectura FOR
                SELECT * FROM PASAJERO WHERE NUM_DOCUMENTO=pNumDocumento;
            END IF;
            
            pRegistro := cursorLectura;            
  END PR_R_PASAJERO;
  
  PROCEDURE CRUD_PASAJERO(
                                pPasajeroId         IN OUT PASAJERO.PASAJERO_ID%TYPE,
                                pPrimerNombre       IN PASAJERO.PRIMERNOMBRE%TYPE,
                                pSegundoNombre      IN PASAJERO.SEGUNDONOMBRE%TYPE,
                                pPrimerApellido     IN PASAJERO.PRIMERAPELLIDO%TYPE,
                                pSegundoApellido    IN PASAJERO.SEGUNDOAPELLIDO%TYPE,
                                pTipoDocumento      IN PASAJERO.TIPO_DOCUMENTO%TYPE,
                                pNumDocumento       IN PASAJERO.NUM_DOCUMENTO%TYPE,                         
                                pFechaNacimiento    IN PASAJERO.FECHANACIMIENTO%TYPE,
                                pPais               IN PASAJERO.PAIS%TYPE,
                                pTelefono           IN PASAJERO.TELEFONO%TYPE,
                                pEmail              IN PASAJERO.EMAIL%TYPE,
                                pClave              IN PASAJERO.CLAVE%TYPE,
                                pTipoOperacion      VARCHAR,
                                pRegistro           OUT var_cursor,
                                pResultado          OUT VARCHAR2,
                                pMsgError           OUT VARCHAR2                                
                              ) AS
  BEGIN
    CASE 
            WHEN pTipoOperacion IS NULL THEN
            pResultado:='NO SE HA INDICADO EL TIPO DE OPERACION';
            RAISE eParametroNull;
            
            WHEN pTipoOperacion=accionINSERT THEN
                    PR_I_PASAJERO(
                                                pPasajeroId         => pPasajeroId
                                                ,pPrimerNombre      => pPrimerNombre 
                                                ,pSegundoNombre     => pSegundoNombre
                                                ,pPrimerApellido    => pPrimerApellido
                                                ,pSegundoApellido   => pSegundoApellido
                                                ,pTipoDocumento     => pTipoDocumento
                                                ,pNumDocumento      => pNumDocumento                                                
                                                ,pFechaNacimiento   => pFechaNacimiento
                                                ,pPais              => pPais
                                                ,pTelefono          => pTelefono
                                                ,pEmail             => pEmail
                                                ,pClave             => pClave
                                                ,pRegistro          => pRegistro
                                                ,pResultado         => pResultado
                                                ,pMsgError          => pMsgError);
            WHEN pTipoOperacion=accionUPDATE THEN
                    PR_U_PASAJERO(
                                                pPasajeroId         => pPasajeroId
                                                ,pPrimerNombre      => pPrimerNombre 
                                                ,pSegundoNombre     => pSegundoNombre
                                                ,pPrimerApellido    => pPrimerApellido
                                                ,pSegundoApellido   => pSegundoApellido
                                                ,pTipoDocumento     => pTipoDocumento
                                                ,pNumDocumento      => pNumDocumento                                                
                                                ,pFechaNacimiento   => pFechaNacimiento
                                                ,pPais              => pPais
                                                ,pTelefono          => pTelefono
                                                ,pEmail             => pEmail
                                                ,pClave             => pClave
                                                ,pRegistro          => pRegistro
                                                ,pResultado         => pResultado
                                                ,pMsgError          => pMsgError);
            WHEN pTipoOperacion=accionDELETE THEN
                    PR_D_PASAJERO(
                                                pPasajeroId         => pPasajeroId                                                
                                                ,pRegistro          => pRegistro
                                                ,pResultado         => pResultado
                                                ,pMsgError          => pMsgError);
            WHEN pTipoOperacion=accionREAD THEN
                    PR_R_PASAJERO(
                                                pPasajeroId         => pPasajeroId
                                                ,pNumDocumento      => pNumDocumento
                                                ,pRegistro          => pRegistro
                                                ,pResultado         => pResultado
                                                ,pMsgError          => pMsgError);
                                                
                CASE WHEN   pMsgError IS NOT NULL THEN
                    RAISE  eSalidaConError; 
                ELSE NULL;                        
                END CASE;    
        ELSE  
            pResultado := 'EL TIPO DE OPERACIÓN  ES INVALIDO';
            RAISE eParametrosInvalidos;
    END CASE;
  END CRUD_PASAJERO;

END PKG_LATINOSTRAVEL;
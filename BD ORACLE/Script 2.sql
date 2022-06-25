create or replace NONEDITIONABLE PACKAGE PKG_LATINOSTRAVEL AS 

eRegistroExiste         EXCEPTION;
eParametrosInvalidos    EXCEPTION;
eParametroNull          EXCEPTION;
eRegistroNoExiste       EXCEPTION;
eSalidaConError         EXCEPTION;

TYPE var_cursor IS REF CURSOR;

accionINSERT    CONSTANT CHAR(1) := 'I';
accionUPDATE    CONSTANT CHAR(1) := 'U';
accionDELETE    CONSTANT CHAR(1) := 'D';
accionREAD      CONSTANT CHAR(1) := 'R';


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
                              );
    
END PKG_LATINOSTRAVEL;
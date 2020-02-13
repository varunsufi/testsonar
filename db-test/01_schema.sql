CREATE USER ACCA IDENTIFIED BY ACCA;
GRANT RESOURCE TO ACCA;
GRANT CONNECT TO ACCA;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE ACCA.STUBBED_ACCOUNT';
  EXCEPTION
  WHEN OTHERS THEN
  IF sqlcode != -0942
  THEN RAISE; END IF;
END;
/

CREATE TABLE ACCA.STUBBED_ACCOUNT (
  USER_NAME VARCHAR2(100),
  ACCOUNT_NUMBER  VARCHAR2(256) NOT NULL,
  ACCOUNT_INDEX NUMBER(10) NOT NULL
);

CREATE OR REPLACE PACKAGE ACCA.AUTENTISERING IS
  PROCEDURE Login(pin_AnvID IN VARCHAR2, pin_Pwd IN VARCHAR2, pin_Captcha IN BOOLEAN, pin_Tf_kod IN NUMBER, put_AccNo OUT VARCHAR2, put_AccIndex OUT NUMBER, put_AnvVillkor OUT NUMBER, put_Tvafaktor OUT NUMBER, put_Medlemid OUT NUMBER, put_AnvId OUT VARCHAR2, put_Tf_kod OUT NUMBER, put_Svar OUT NUMBER);
END AUTENTISERING;
/

CREATE OR REPLACE PACKAGE BODY ACCA.AUTENTISERING IS
  --                   0 = Tekniskt fel
  --                   1 = Inloggning OK
  --                   2 = Felaktig inloggning, gränssnittet ska inte visa captcha
  --                   3 = Felaktig inloggning, gränssnittet ska visa captcha
  --                   4 = Användarnamn finns, kontot spärrat
  --                   5 = Korrekt inloggning, men temp lösen ska bytas
  --                   6 = Korrekt inloggning, temp lösen är äldre än 24 h
  --                   7 = Konto finns men det finns felaktiga inloggningsförsök. Fråga om med captcha
  --                   8 = Felaktig inloggning, SISTA försöket

  PROCEDURE Login(pin_AnvID IN VARCHAR2, pin_Pwd IN VARCHAR2, pin_Captcha IN BOOLEAN, pin_Tf_kod IN NUMBER, put_AccNo OUT VARCHAR2, put_AccIndex OUT NUMBER, put_AnvVillkor OUT NUMBER, put_Tvafaktor OUT NUMBER, put_Medlemid OUT NUMBER, put_AnvId OUT VARCHAR2, put_Tf_kod OUT NUMBER, put_Svar OUT NUMBER) IS
    CURSOR findCustomer IS
      SELECT
        customer.USER_NAME,
        customer.ACCOUNT_NUMBER,
        customer.ACCOUNT_INDEX
      FROM ACCA.STUBBED_ACCOUNT customer
      WHERE customer.USER_NAME = pin_AnvID;

    userName ACCA.STUBBED_ACCOUNT.USER_NAME%TYPE;
    accountNumber ACCA.STUBBED_ACCOUNT.ACCOUNT_NUMBER%TYPE;
    accountIndex ACCA.STUBBED_ACCOUNT.ACCOUNT_INDEX%TYPE;

    BEGIN
      OPEN findCustomer;
      FETCH findCustomer INTO userName, accountNumber, accountIndex;

      IF userName = 'UserThatCanLoginSuccessfully' THEN
        put_AnvId := userName;
        put_AccNo := accountNumber;
        put_AccIndex := accountIndex;
        put_Svar := 1;
      END IF;

      IF pin_AnvID = 'UserWithInvalidCredentials' THEN
        put_Svar := 0;
      END IF;
    END Login;
END AUTENTISERING;
/

GRANT EXECUTE ON ACCA.AUTENTISERING TO ACCA
/
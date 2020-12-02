#Include "Protheus.ch"

User Function MA410MNU() 
//SetKey(VK_F2, {||U_M410INIC()})

//aadd(aRotina,{'Obs. Cliente','U_ConCli()' , 0 , 3,0,NIL})   

Return (aRotina)

User Function ConCli()

Local aArea     := GetArea()
Local cCliente  := SC5->C5_CLIENTE
Local cAliasTop := GetNextAlias()
Local cChave    := "" 
Local cRetorno  := ""
Local lInclui   := IsInCallStack("A410Inclui")
Local lAltera   := IsInCallStack("A410Altera")

If  !lInclui .And. !lAltera
	cQuery := "SELECT R_E_C_N_O_, * FROM "
	cQuery += RetSqlName("SA1") + " SA1 "
	cQuery += "WHERE A1_COD = '" + cCliente + "' AND D_E_L_E_T_ = ' ' "
		
	cQuery := ChangeQuery(cQuery) 
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTop,.T.,.T.)
	
	(cAliasTop)->(dbGotop())
	
	If !Empty ((cAliasTop)->A1_OBS)
		cChave      := (cAliasTop)->A1_OBS
	//Else
		//Alert("Cliente não possui observações")
	EndIf
	
	DbCloseArea(cAliasTop)
	
	cRetorno := U_BuscaSYP(cChave)
	
	RestArea(aArea)

EndIf

Return cRetorno


User Function BuscaSYP(cChave)

Local aArea     := GetArea()
Local cAliasTop := GetNextAlias()
Local cObs      := "" 

cQuery := "SELECT * FROM "
cQuery += RetSqlName("SYP") + " SYP "
cQuery += "WHERE YP_CHAVE = '" + cChave + "' AND D_E_L_E_T_ = ' ' "
	
cQuery := ChangeQuery(cQuery) 

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasTop,.T.,.T.)

(cAliasTop)->(dbGotop())

Do While !(cAliasTop)->(Eof())
	
	cObs += (cAliasTop)->YP_TEXTO
	
	(cAliasTop)->(dbskip())		

EndDo

//U_MsgPlasti(cObs)

DbCloseArea(cAliasTop)

RestArea(aArea)

Return   cObs

User Function MsgPlasti(cObs)

Local lRetMens             := .F.
Local oDlgMens
Local oBtnOk, cTxtConf     := ""
Local oBtnCnc, cTxtCancel  := ""
Local oBtnSlv
Local oFntTxt              := TFont():New("Verdana",,-011,,.F.,,,,,.F.,.F.)
Local oMsg
Local nIni                 := 1
Local nFim                 := 50
Local cMsg                 := ""
Local cTitulo              := "Observação Cliente"
Local cQuebra              := CRLF + CRLF
Local nTipo                := 1 // 1=Ok; 2= Confirmar e Cancelar
Local lEdit                := .F.
Local nX                   := 0

cMsg   := cObs
cTexto := cMsg

//Definindo os textos dos botões
If(nTipo == 1)
	cTxtConf:='Ok'
Else
	cTxtConf:='Confirmar'
	cTxtCancel:='Cancelar'
	EndIf
 
    //Criando a janela centralizada com os botões
DEFINE MSDIALOG oDlgMens TITLE cTitulo FROM 000, 000  TO 300, 400 COLORS 0, 16777215 PIXEL
    //Get com o Log
@ 002, 004 GET oMsg VAR cTexto OF oDlgMens MULTILINE SIZE 191, 121 FONT oFntTxt COLORS 0, 16777215 HSCROLL PIXEL
If !lEdit
	oMsg:lReadOnly := .T.
EndIf
     
    //Se for Tipo 1, cria somente o botão OK
If (nTipo==1)
	@ 127, 144 BUTTON oBtnOk  PROMPT cTxtConf   SIZE 051, 019 ACTION (lRetMens:=.T., oDlgMens:End()) OF oDlgMens PIXEL
     
    //Senão, cria os botões OK e Cancelar
ElseIf(nTipo==2)
	@ 127, 144 BUTTON oBtnOk  PROMPT cTxtConf   SIZE 051, 009 ACTION (lRetMens:=.T., oDlgMens:End()) OF oDlgMens PIXEL
	@ 137, 144 BUTTON oBtnCnc PROMPT cTxtCancel SIZE 051, 009 ACTION (lRetMens:=.F., oDlgMens:End()) OF oDlgMens PIXEL
EndIf
     
ACTIVATE MSDIALOG oDlgMens CENTERED
 
Return lRetMens
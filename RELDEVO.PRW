#include "topconn.ch"   
#INCLUDE "Rwmake.ch"
#INCLUDE "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RelDevo  ºAutor  ³André Brito      º Data ³  25/06/2020    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório de Despesas de Importacao                TReport º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PlastReal                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User function RelDevo()
  
Private  oReport                                                   
Private cPerg       := "RELDEVO"
Private cAliasTop   := GetNextAlias() 
Private cAliasSB6   := GetNextAlias()
Private cAlias      := GetNextAlias()
Private cProtocolo	:= "TCPIP"
Private cStrConn	:= ""
Private cServConn	:= ""
Private nConTOTVS	:= 0
Private nConBAAN    := 0

if ! Pergunte(cPerg, .T.)
	Return nil
endif
                       
oReport := reportDef()
oReport:PrintDialog()

Return nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef  ºAutor  ³André Brito        º Data ³  25/06/2020 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ ReportDef Definições da celulas                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PlastReal                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport
local cTitle  := "Relatorio de Devoluções"
local cHelp   := "Relatorio de Devoluções"
Private oSection ,oSectionDv,oCabSai,oCabdev
                    
oReport:= TReport():New("RelDevo",cTitle,cPerg,{|oReport|ReportPrint(oReport)},cHelp)
//oReport := TReport():New("RGESCOM","Ralatorio Gestão de Comissões", cPerg , {|oReport| ReportPrint(oReport)} , " COMISSOES" )

oReport:SetPortrait()                                                               

oCabEst:= TRSection():New(oReport,"")   


oSection := TRSection():New(oReport,"Despesas", cAliasTop)      
                                                              
TRCell():New(oSection, "DataNf"  	   , cAliasTop, "Data NF Devolucao",,TamSX3("D1_DTDIGIT")[1])       
TRCell():New(oSection, "TipoNf"        , cAliasTop, "Tipo NF",,TamSX3("D1_TIPO")[1]) //WD_HAWB   	  
TRCell():New(oSection, "NumeroNf"      , cAliasTop, "Numero NF",,TamSX3("D1_DOC")[1])     
TRCell():New(oSection, "SerieNf"       , cAliasTop, "Serie NF",,TamSX3("D1_SERIE")[1])  
TRCell():New(oSection, "CodFornec"     , cAliasTop, "Cod. Fornecedor",,TamSX3("D1_FORNECE")[1])
TRCell():New(oSection, "SerieDev"      , cAliasTop, "Serie Devolucao",,TamSX3("D1_SERIORI")[1])
TRCell():New(oSection, "TotalDev"  	   , cAliasTop, "Total Devolucao",,TamSX3("F1_VALBRUT")[1])       
TRCell():New(oSection, "NotaSaida"     , cAliasTop, "Num. Nota Saida",,TamSX3("F2_DOC")[1]) //WD_HAWB   	  
TRCell():New(oSection, "Serie"         , cAliasTop, "Serie DV",,TamSX3("F2_SERIE ")[1])     
TRCell():New(oSection, "DtEmissao"     , cAliasTop, "Data Emissao",,TamSX3("F2_EMISSAO")[1])  
TRCell():New(oSection, "CodCliente"    , cAliasTop, "Cod. Cliente",,TamSX3("F2_CLIENTE")[1])
TRCell():New(oSection, "Loja"  	       , cAliasTop, "Loja Cliente",,TamSX3("F2_LOJA")[1])
TRCell():New(oSection, "NomeCliente"   , cAliasTop, "Nome Cliente",,TamSX3("A1_NOME")[1])     
TRCell():New(oSection, "TotalNf"       , cAliasTop, "Total NF",,TamSX3("F2_VALBRUT")[1])  
TRCell():New(oSection, "NumTitulo"     , cAliasTop, "Numero do Titulo",,TamSX3("E1_NUM")[1])
TRCell():New(oSection, "Prefixo"  	   , cAliasTop, "Prefixo",,TamSX3("E1_PREFIXO")[1])
TRCell():New(oSection, "Parcela"  	   , cAliasTop, "Parcela",,TamSX3("E1_PARCELA")[1])
TRCell():New(oSection, "Tipo"          , cAliasTop, "Tipo",,TamSX3("E1_TIPO")[1])     
TRCell():New(oSection, "Valor"         , cAliasTop, "Valor",,TamSX3("E1_VALOR")[1])  
TRCell():New(oSection, "Vendedor"  	   , cAliasTop, "Vendedor",,TamSX3("E1_VEND1")[1])
TRCell():New(oSection, "NomeVend"  	   , cAliasTop, "Nome Vendedor",,TamSX3("A3_NOME")[1])

return (oReport)
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  RelDevo    ºAutor  ³André Brito      º Data ³  25/06/2020    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatório Despesas de Importacao                   TReport º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PlastReal                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint()
Local oSection    := oReport:Section(2) 
Local oCabEst     := oReport:Section(1)
Local oSectiongs  := oReport:Section(3) 
Local cQuery      :="" 
Local cQueryB6    :="" 
Local dEmissao    :=""
Local wHamb       :=""
Local vTotal      :=0
//Local xDataini,xDataFim

xDataBase:=SUBSTR(DTOS(dDataBase),7,2)+'/'+SUBSTR(DTOS(dDataBase),5,2)+'/'+SUBSTR(DTOS(dDataBase),3,2) 
//xDataFim:=SUBSTR(DTOS(MV_PAR08),7,2)+'/'+SUBSTR(DTOS(MV_PAR08),5,2)+'/'+SUBSTR(DTOS(MV_PAR08),3,2)

cQuery := "SELECT DISTINCT Substring(D1_DTDIGIT, 7, 2) + '/'" 
cQuery +=               "+ Substring(D1_DTDIGIT, 5, 2) + '/' 
cQuery +=               " + Substring(D1_DTDIGIT, 1, 4) AS 'DATANFDEV', 
cQuery +=                "D1_TIPO                       AS 'TIPONF', 
cQuery +=                "D1_DOC                        AS 'NUMERONF', 
cQuery +=                "D1_SERIE                      AS 'SERIENF', 
cQuery +=                "D1_FORNECE                    AS 'CODFORNEC', 
cQuery +=                "D1_NFORI                      AS 'NUMNOTAORIGEM', 
cQuery +=                "D1_SERIORI                    AS 'SERIEDV ', 
cQuery +=                "F1_VALBRUT                    AS 'TOTALDEVOLUCAO', 
cQuery +=                "F2_DOC                        AS 'NOTASAIDA', 
cQuery +=                "F2_SERIE                      AS 'SERIE', 
cQuery +=                "Substring(F2_EMISSAO, 7, 2) + '/' 
cQuery +=                "+ Substring(F2_EMISSAO, 5, 2) + '/' 
cQuery +=                "+ Substring(F2_EMISSAO, 1, 4) AS 'EMISSAO', 
cQuery +=                "F2_CLIENTE                    AS 'CODCLIENTE', 
cQuery +=                "F2_LOJA                       AS 'LOJA', 
cQuery +=                "A1_NOME                       AS 'NOMECLIENTE', 
cQuery +=                "F2_VALBRUT                    AS 'TOTALNF', 
cQuery +=                "E1_NUM                        AS 'NUMEROTITULO', 
cQuery +=                "E1_PREFIXO                    AS 'PREFIXO',  
cQuery +=                "E1_TIPO                       AS 'TIPO',  
cQuery +=                "E1_VEND1                      AS 'VENDEDOR', 
cQuery +=                "A3_NOME                       'NOMEVENDEDOR' 
cQuery += "FROM   SD1010 
cQuery +=       "LEFT JOIN SF2010 
cQuery +=              "ON F2_DOC = D1_NFORI 
cQuery +=                 "AND F2_SERIE = D1_SERIORI 
cQuery +=                 "AND F2_CLIENTE = D1_FORNECE 
cQuery +=                 "AND F2_LOJA = D1_LOJA 
cQuery +=                 "AND SF2010.D_E_L_E_T_ = '' 
cQuery +=       "LEFT JOIN SF1010 
cQuery +=              "ON F1_DOC = D1_DOC 
cQuery +=                 "AND F1_SERIE = D1_SERIE 
cQuery +=                 "AND F1_FORNECE = D1_FORNECE 
cQuery +=                 "AND F1_LOJA = D1_LOJA 
cQuery +=                 "AND SF1010.D_E_L_E_T_ = '' 
cQuery +=       "LEFT JOIN SE1010 
cQuery +=              "ON E1_NUM = F2_DOC 
cQuery +=                 "AND E1_PREFIXO = F2_SERIE 
cQuery +=                 "AND E1_CLIENTE = F2_CLIENTE 
cQuery +=                 "AND E1_LOJA = F2_LOJA 
cQuery +=                 "AND SE1010.D_E_L_E_T_ = '' 
cQuery +=       "LEFT JOIN SA1010 
cQuery +=              "ON A1_COD = F2_CLIENTE 
cQuery +=                 "AND A1_LOJA = F2_LOJA 
cQuery +=                 "AND SA1010.D_E_L_E_T_ = '' 
cQuery +=       "LEFT JOIN SA3010 
cQuery +=              "ON A3_COD = E1_VEND1 
cQuery +=                 "AND SA3010.D_E_L_E_T_ = '' 
cQuery +=		"WHERE  D1_TIPO = '" + MV_PAR01 + "'" 
//cQuery +=       "AND D1_DTDIGIT >'" + Dtos(MV_PAR02) + "'"
cQuery += 		" AND D1_DTDIGIT BETWEEN '" + Dtos(MV_PAR02) + "' AND '" + Dtos(MV_PAR03) + "'" 
cQuery +=       "AND SD1010.D_E_L_E_T_ = '' "
cQuery += "GROUP BY D1_DTDIGIT,D1_TIPO, E1_NUM,D1_SERIE , D1_DOC, D1_FORNECE, D1_NFORI, D1_SERIORI, F1_VALBRUT, F2_DOC, F2_SERIE, F2_EMISSAO, F2_EMISSAO, F2_EMISSAO,F2_VALBRUT, F2_CLIENTE,F2_LOJA,A1_NOME,E1_NUM ,E1_PREFIXO,E1_TIPO,E1_VEND1,A3_NOME"

dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),cAliasTop,.F.,.F.)

DbSelectArea(cAliasTop)             
(cAliasTop)->(DbGoTop ())

oReport:SetMeter((cAliasTop)->(LastRec()))	

TRCell():New(oCabEst,"",,"RELATORIO DE DEVOLUCOES EM: "+xDataBase,) 
oCabEst:Init()
oCabEst:PrintLine() 
oReport:SkipLine(2)

oSection:init()                                                   

lflag:=.T.
While (cAliasTop)->(!EOF()) 
	If oReport:Cancel()
	   Exit
	EndIf
	
   	oReport:IncMeter()   	
	osection:cell("DataNf"):SetValue((cAliasTop)->DATANFDEV) 
	osection:cell("TipoNf"):SetValue((cAliasTop)->TIPONF)
	osection:cell("NumeroNf"):SetValue((cAliasTop)->NUMERONF)
	osection:cell("SerieNf"):SetValue((cAliasTop)->SERIENF)		
	osection:cell("CodFornec"):SetValue((cAliasTop)->CODFORNEC)   
	//dEmissao:=SUBSTR((cAliasTop)->WD_DES_ADI,7,2)+'/'+SUBSTR((cAliasTop)->WD_DES_ADI,5,2)+'/'+SUBSTR((cAliasTop)->WD_DES_ADI,1,4)
	//osection:cell("DATADES"):SetValue(dEmissao)     	
	osection:cell("SerieDev"):SetValue((cAliasTop)->SERIE) 
	osection:cell("TotalDev"):SetValue((cAliasTop)->TOTALDEVOLUCAO)
	osection:cell("NotaSaida"):SetValue((cAliasTop)->NOTASAIDA)	
	osection:cell("DtEmissao"):SetValue((cAliasTop)->EMISSAO)   	
	osection:cell("CodCliente"):SetValue((cAliasTop)->CODCLIENTE) 
	osection:cell("Loja"):SetValue((cAliasTop)->LOJA)
	osection:cell("NomeCliente"):SetValue((cAliasTop)->NOMECLIENTE)
	osection:cell("TotalNf"):SetValue((cAliasTop)->TOTALNF)		
	osection:cell("NumTitulo"):SetValue((cAliasTop)->NUMEROTITULO)   
	osection:cell("Prefixo"):SetValue((cAliasTop)->PREFIXO)  	
	osection:cell("Tipo"):SetValue((cAliasTop)->TIPO)   
	osection:cell("Vendedor"):SetValue((cAliasTop)->VENDEDOR)   
	osection:cell("NomeVend"):SetValue((cAliasTop)->NOMEVENDEDOR) 
	 
	//vTotal:= vTotal+(cAliasTop)->WD_VALOR_R 
	
	oSection:PrintLine()
	
	(cAliasTop)->(DbSkip())	
/*
	If wHawb <> (cAliasTop)->WD_HAWB
	 	osection:cell("FILIAL"):Disable 
		osection:cell("PROCESSO"):Disable
		osection:cell("CODESPESA"):Disable
		osection:cell("DESCDESPESA"):Disable		
		osection:cell("VALORDES"):Disable 
		osection:cell("DATADES"):Disable	
		osection:cell("VALORDES"):SetValue(vTotal)   
		oSection:PrintLine()	
		wHawb:=(cAliasTop)->WD_HAWB
	 Endif	
*/	
EndDo             

oReport:ThinLine()
oSection:Finish()	
(cAliasTop)->(DbCloseArea())
Return Nil
Attribute VB_Name = "MVersion"
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010

Public Function VerificarVersion(sqlconn As Long, nombrearchivo As String, mayor As Integer, menor As Integer, revision As Integer, modulo As Integer) As Boolean
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "28744"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "V"
    PMPasoValores sqlconn&, "@i_modulo", 0, SQLINT2, modulo
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "0"
    PMPasoValores sqlconn&, "@i_archivo", 0, SQLCHAR, nombrearchivo
    PMPasoValores sqlconn&, "@i_numero1", 0, SQLINT2, mayor
    PMPasoValores sqlconn&, "@i_numero2", 0, SQLINT2, menor
    PMPasoValores sqlconn&, "@i_numero3", 0, SQLINT2, revision
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_control_version", True, " Ingresa Versión") Then
        PMChequea sqlconn&
        VerificarVersion = True
    Else
        VerificarVersion = False
    End If
    
End Function



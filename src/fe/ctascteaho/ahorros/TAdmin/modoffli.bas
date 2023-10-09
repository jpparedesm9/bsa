Attribute VB_Name = "modoffli"
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
' Objetivo: Funciones para el funcionamiento del modo SAIP
'
' Diseñado: Fabricio Velasco V.
' Fecha de creacion: 26/Ago/1998


'Determinar si existe o no linea
Global VGOnline As Integer

'Determinar si se trabajará en modo SAIP
Global VGSaip As String



Sub FMCerrarFormas()

    'LLamar a Rutina de Cerrar Ventanas
    DoEvents
    SendKeys "{Esc}"
    SendKeys "{Esc}"
    'Cerrar las ventanas activas
        Do While True
            If Screen.ActiveForm.Caption <> FPrincipal.Caption Then
                Unload Screen.ActiveForm
            Else
                Exit Do
            End If
        Loop
End Sub


' PROPOSITO: Activar los menus cuando se va la línea
'
' ESCRITO POR: Rosa Elena Quintero Villarreal
' FECHA : 26/Ago/1998
Function FMActivaMenuSaip(ByVal parStatus As Integer) As Integer
  FPrincipal!pnlTransaccionLine.Caption = " Capturando transacciones SAIP..."
  FPrincipal!mnuLogon.Enabled = False
  FPrincipal!mnuLogoff.Enabled = True
  FPrincipal!mnuPassword.Enabled = False
  FPrincipal!mnuCorrientes.Enabled = False
  FPrincipal!mnuAhorros.Enabled = False
  FPrincipal!mnuReCamara.Enabled = False
  'FPrincipal!mnuContenido.Enabled = True
  FPrincipal!mnuBloquear.Enabled = True
  FPrincipal!mnuadmin.Enabled = False
  FPrincipal!mnufueralinea.Enabled = True
   
  PMMenuSeguridad FPrincipal!mnuflap(0)
  PMMenuSeguridad FPrincipal!mnuflblq(0)
  PMMenuSeguridad FPrincipal!mnuflblq(1)
  PMMenuSeguridad FPrincipal!mnufllev(0)
  'PMMenuSeguridad FPrincipal.mnuflentchq(0)
  'PMMenuSeguridad FPrincipal.mnuflrecpchq(0)
  PMMenuSeguridad FPrincipal!mnufllev(1)
  PMMenuSeguridad FPrincipal!mnuflchq(0)
  PMMenuSeguridad FPrincipal!mnuflchq(1)
  PMMenuSeguridad FPrincipal!mnuflcon(0)
  PMMenuSeguridad FPrincipal!mnuflcon(1)
  PMMenuSeguridad FPrincipal!mnuflcon(2)
  PMMenuSeguridad FPrincipal!mnuflcon(3)
  PMMenuSeguridad FPrincipal!mnuflahoap(0)
  PMMenuSeguridad FPrincipal!mnuflahoblq(0)
  PMMenuSeguridad FPrincipal!mnuflahoblq(1)
  PMMenuSeguridad FPrincipal!mnuflaholev(0)
  PMMenuSeguridad FPrincipal!mnuflaholev(1)
  PMMenuSeguridad FPrincipal!mnuflahocon(0)
  PMMenuSeguridad FPrincipal!mnuflahocon(1)
  PMMenuSeguridad FPrincipal!mnuflahocon(2)
  PMMenuSeguridad FPrincipal!mnuflahocon(3)
  PMMenuSeguridad FPrincipal!mnuflentchqini(0)
End Function
' PROPOSITO: Activar los menus después que regresa la línea
'
' ESCRITO POR: Rosa Elena Quintero Villarreal
' FECHA : 26/Ago/1998
Function FMActivaMenu(ByVal parStatus As Integer) As Integer
    Dim i As Integer
    
  FPrincipal!pnlTransaccionLine.Caption = " Capturando transacciones..."
  FPrincipal!mnuLogon.Enabled = False
  FPrincipal!mnuLogoff.Enabled = True
  FPrincipal!mnuPassword.Enabled = True
  FPrincipal!mnuCorrientes.Enabled = True
  FPrincipal!mnuAhorros.Enabled = True
  FPrincipal!mnuReCamara.Enabled = True
  FPrincipal!mnucanje.Enabled = True
  'FPrincipal!mnuContenido.Enabled = True
  FPrincipal!mnuBloquear.Enabled = True
  FPrincipal!mnuadmin.Enabled = True
  FPrincipal!mnufueralinea.Enabled = False
  
  If VGSaip$ = "N" Then
    FPrincipal!mnufueralinea.Visible = False
  Else
    FPrincipal!mnufueralinea.Visible = True
  End If
  
  
  
  
  For i% = 0 To 6
    PMMenuSeguridad FPrincipal!mnuTran(i%)
  Next i%
  For i% = 0 To 11
    PMMenuSeguridad FPrincipal!mnuTran0(i%)
  Next i%
  For i% = 0 To 2
    PMMenuSeguridad FPrincipal!mnuTran1(i%)
  Next i%
  PMMenuSeguridad FPrincipal!mnuTran1(3)
  PMMenuSeguridad FPrincipal!mnuTran1(5)
  PMMenuSeguridad FPrincipal!mnuTran1(6)
  PMMenuSeguridad FPrincipal!mnuTran1(7)
  PMMenuSeguridad FPrincipal!mnuTran1(8)
  PMMenuSeguridad FPrincipal!mnuTran1(10)
  PMMenuSeguridad FPrincipal!mnuTran1(12)
  PMMenuSeguridad FPrincipal!mnuTran1(14)
  PMMenuSeguridad FPrincipal!mnuTran1(15)
  PMMenuSeguridad FPrincipal!mnuTran1(17)
  
  PMMenuSeguridad FPrincipal!mnuTran2(0)
  PMMenuSeguridad FPrincipal!mnuTran2(1)
  PMMenuSeguridad FPrincipal!mnuTran2(2)
  PMMenuSeguridad FPrincipal!mnuTran2(3)
  PMMenuSeguridad FPrincipal!mnuTran2(4)
  
  PMMenuSeguridad FPrincipal!mnuTran3(0)
  PMMenuSeguridad FPrincipal!mnuTran3(1)
  PMMenuSeguridad FPrincipal!mnuTran4(0)
  PMMenuSeguridad FPrincipal!mnuTran4(1)
  For i% = 0 To 3
    PMMenuSeguridad FPrincipal!mnuTran5(i%)
  Next i%
  For i% = 0 To 3
    PMMenuSeguridad FPrincipal!mnuTran6(i%)
  Next i%
  
  PMMenuSeguridad FPrincipal!mnuTran61
  PMMenuSeguridad FPrincipal!mnuSusp(4)
  PMMenuSeguridad FPrincipal!mnuTran7(0)
  PMMenuSeguridad FPrincipal!mnuTran7(1)
  PMMenuSeguridad FPrincipal!mnuTran7(2)
  PMMenuSeguridad FPrincipal!mnuTran7(8)
  PMMenuSeguridad FPrincipal!mnuTran7(9)
  PMMenuSeguridad FPrincipal!mnuTran7(10)
  PMMenuSeguridad FPrincipal!mnuTran7(11)
  PMMenuSeguridad FPrincipal!mnuTran7(13)
  PMMenuSeguridad FPrincipal!mnuTran7(14)
  PMMenuSeguridad FPrincipal!mnuTran7(15)
  PMMenuSeguridad FPrincipal!mnuTran7(17)
  PMMenuSeguridad FPrincipal!mnuTran7(18)
  PMMenuSeguridad FPrincipal!mnuTran7(19)
  PMMenuSeguridad FPrincipal!mnuTran7(21)
  PMMenuSeguridad FPrincipal!mnuTran7(23)
  PMMenuSeguridad FPrincipal!mnuTran7(24)
  PMMenuSeguridad FPrincipal!mnuTran7(25)
  PMMenuSeguridad FPrincipal!mnuTran7(26)
  PMMenuSeguridad FPrincipal!mnuTran7(27)
  PMMenuSeguridad FPrincipal!mnuTran7(28)
  PMMenuSeguridad FPrincipal!mnuTranctacte(10)
  PMMenuSeguridad FPrincipal!mnuTranctacte(11)
  PMMenuSeguridad FPrincipal!mnuTranctacte(12)
  PMMenuSeguridad FPrincipal!mnuTranctacte(14)
  PMMenuSeguridad FPrincipal!mnuTran8(1)
  PMMenuSeguridad FPrincipal!mnuTran8(2)
  PMMenuSeguridad FPrincipal!mnuTran8(3)
  PMMenuSeguridad FPrincipal!mnuTran8(4)
  PMMenuSeguridad FPrincipal!mnuTranctaaho(4)
  PMMenuSeguridad FPrincipal!mnuTranctaaho(6)
  PMMenuSeguridad FPrincipal!mnuTranAho1(0)
  PMMenuSeguridad FPrincipal!mnuTranAho1(1)
  PMMenuSeguridad FPrincipal!mnuTranAho1(2)
  PMMenuSeguridad FPrincipal!mnuTranAho1(3)
  PMMenuSeguridad FPrincipal!mnuTranAho2(0)
  PMMenuSeguridad FPrincipal!mnuTranAho2(1)
  PMMenuSeguridad FPrincipal!mnuTranAho3(0)
  PMMenuSeguridad FPrincipal!mnuTranAho3(1)
  PMMenuSeguridad FPrincipal!mnuTranAho6(0)
  PMMenuSeguridad FPrincipal!mnuTranAho6(1)
  PMMenuSeguridad FPrincipal!mnuTranAho7(0)
  PMMenuSeguridad FPrincipal!mnuTranAho7(1)
  PMMenuSeguridad FPrincipal!mnuTranAho7(2)
  PMMenuSeguridad FPrincipal!mnuTranAho7(3)
  PMMenuSeguridad FPrincipal!mnuTranAho7(5)
  PMMenuSeguridad FPrincipal!mnuTranAho7(6)
  PMMenuSeguridad FPrincipal!mnuTranAho7(7)
  PMMenuSeguridad FPrincipal!mnuTranAho7(8)
  PMMenuSeguridad FPrincipal!mnuTranAho7(9)
  PMMenuSeguridad FPrincipal!mnuTranAho7(14)
  PMMenuSeguridad FPrincipal!mnuTranAho7(15)
  PMMenuSeguridad FPrincipal!mnuTranAho8(1)
  PMMenuSeguridad FPrincipal!mnuTranAho8(2)
  
 'J.C.H
 PMMenuSeguridad FPrincipal!mnuAhoPro(1)
 PMMenuSeguridad FPrincipal!mnuAhoPro(2)
 PMMenuSeguridad FPrincipal!mnuAhoPro(3)
 PMMenuSeguridad FPrincipal!mnuAhoPro(4)
 PMMenuSeguridad FPrincipal!mnuAhoPro(5)
 PMMenuSeguridad FPrincipal!mnuAhoPro(6)
 PMMenuSeguridad FPrincipal!mnuAhoPro(7)
 PMMenuSeguridad FPrincipal!mnuAhoPro(8)
 ' J.C.H
 
  PMMenuSeguridad FPrincipal!mnuImpuestos(1)
  PMMenuSeguridad FPrincipal!mnuImpuestos(2)
  PMMenuSeguridad FPrincipal!mnuImpuestos(3)
  PMMenuSeguridad FPrincipal!mnuImpuestos(4)
  PMMenuSeguridad FPrincipal!mnuImpuestos(5)
  'PMMenuSeguridad FPrincipal!mnuImpuestos(6)
  PMMenuSeguridad FPrincipal!mnuImpuestos(7)
  For i% = 0 To 4
    PMMenuSeguridad FPrincipal!mnuTranRemesas(i%)
  Next i%
  For i% = 0 To 5
    PMMenuSeguridad FPrincipal!mnuCamara(i%)
  Next i%
  
  PMMenuSeguridad FPrincipal!mnuChqDev(0)
  PMMenuSeguridad FPrincipal!mnuChqDev(1)
  PMMenuSeguridad FPrincipal!mnuChqDev(2)
  PMMenuSeguridad FPrincipal!mnuChqDev(3)
  PMMenuSeguridad FPrincipal!mnuAdmin0(0)
  PMMenuSeguridad FPrincipal!mnuAdmin0(1)
  PMMenuSeguridad FPrincipal!mnuAdmin0(6)
  PMMenuSeguridad FPrincipal!mnuAdmin3(7)
  PMMenuSeguridad FPrincipal!mnuAdmin3(8)
  PMMenuSeguridad FPrincipal!mnuCausaNdNc
  PMMenuSeguridad FPrincipal!mnuadmin4(8)
  PMMenuSeguridad FPrincipal!mnuAdmin5(9)
  PMMenuSeguridad FPrincipal!mnuadmin6(10)
  PMMenuSeguridad FPrincipal!mnuadmin6(11)
  
  PMMenuSeguridad FPrincipal!mnuConvenio(0)
  PMMenuSeguridad FPrincipal!mnuConvenio(1)
  PMMenuSeguridad FPrincipal!mnuConvenio(2)
  PMMenuSeguridad FPrincipal!mnuConvenio(3)     'CPA Mantenimiento Usuarios Puntos

  If VGSaip$ = "S" Then
    PMMenuSeguridad FPrincipal!mnuAdmin7(2)
  Else
    FPrincipal!mnuAdmin7(1).Visible = False
    FPrincipal!mnuAdmin7(2).Visible = False
  End If
  For i% = 0 To 2
    PMMenuSeguridad FPrincipal!mnuAdmin2(i%)
  Next i%
  For i% = 0 To 4
    PMMenuSeguridad FPrincipal!mnuCheq(i%)
  Next i%
  'II - ACO
  PMMenuSeguridad FPrincipal!mnuTran71(0)
  PMMenuSeguridad FPrincipal!mnuTran71(1)
  PMMenuSeguridad FPrincipal!mnuTran72(0)
  PMMenuSeguridad FPrincipal!mnuTran72(1)
  PMMenuSeguridad FPrincipal!mnuTalonarios(0)
  PMMenuSeguridad FPrincipal!mnuTalonarios(1)
  PMMenuSeguridad FPrincipal!mnuTalonarios(2)
  PMMenuSeguridad FPrincipal!mnucierreaho(10)
  PMMenuSeguridad FPrincipal!mnuctaPerson
  PMMenuSeguridad FPrincipal!mnutranefe
  PMMenuSeguridad FPrincipal!MnuCuenCon
  PMMenuSeguridad FPrincipal!mnuMantPremios
  PMMenuSeguridad FPrincipal!mnuAdmPuntos
  PMMenuSeguridad FPrincipal!MnuImprimeNDNC
  PMMenuSeguridad FPrincipal!mnuflrecpchq(0)
  PMMenuSeguridad FPrincipal!mnuOffSafe(3)
  PMMenuSeguridad FPrincipal!mnuflentchq(0)
  PMMenuSeguridad FPrincipal!mnuBcoCedente
  
  PMMenuSeguridad FPrincipal!mnuvaucher
  PMMenuSeguridad FPrincipal!mnuCentroCanje
  PMMenuSeguridad FPrincipal!mnuAdmin0(1)
  PMMenuSeguridad FPrincipal!mnuPlazasBcoRep
  PMMenuSeguridad FPrincipal!mnuParamcanje
  PMMenuSeguridad FPrincipal!mnucresecofi
  PMMenuSeguridad FPrincipal!mnucanje
  PMMenuSeguridad FPrincipal!mnuRecAgr
  PMMenuSeguridad FPrincipal!mnudatae
  PMMenuSeguridad FPrincipal!mnucarterizacion
  PMMenuSeguridad FPrincipal!mnuCausaIE
  PMMenuSeguridad FPrincipal!mnuexconsol
  
  PMMenuSeguridad FPrincipal!mnuMnTrNoPer     'MZA Mantenimiento trans. no permitidas ctas Ahorro
  PMMenuSeguridad FPrincipal!mnuCExeGMF       'ccb parametrizacion de conceptos GMF
  PMMenuSeguridad FPrincipal!mnuConChqGer
  PMMenuSeguridad FPrincipal!mnuCtaConsOfi
  
  PMMenuSeguridad FPrincipal!mnuTotales(0)
  PMMenuSeguridad FPrincipal!mnuTotales(1)
  PMMenuSeguridad FPrincipal!mnuTotales(2)
  PMMenuSeguridad FPrincipal!mnuTotales(3)
  PMMenuSeguridad FPrincipal!mnuTotales(4)
  PMMenuSeguridad FPrincipal!mnuMtoEquiv
  
  FMActivaMenu% = True
End Function

' PROPOSITO: Disparar el stored procedure sp_mail para recibir mensajes de otros usuarios o del servidor cada n tiempo
'
' ESCRITO POR: Rosa Elena Quintero Villarreal
' FECHA : 26/Ago/1998


Function FMGetMail(ByVal parServer As String) As Integer
    Dim VTR1 As Integer
    Dim VTR2 As Integer
    
  ReDim VTArreglo1(20) As String
  ReDim VTarreglo2(50) As String
  
  
    If FMTransmitirRPC(sqlconn&, parServer$, "cobis", "sp_mail", False, "") Then
    VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo1())
    VTR2% = FMMapeaArreglo(sqlconn&, VTarreglo2())
    PMChequea sqlconn&
    If Trim$(VTArreglo1(1)) <> "N" Then  ' Mensaje de Informacion general
      If Trim$(VTarreglo2(1)) = "I" Then
        If Trim$(VTarreglo2(2)) = "[L:]0" Then
          If VGOnline% Then
            MsgBox "Servidor Central Fuera de Línea, Mensaje del Servidor, Administrador"
            VGOnline% = False
            FMCerrarFormas
            FMActivaMenuSaip True
            FPrincipal!pnlTransaccionLine = "OFF LINE"
          End If
          Exit Function
        End If
    
        If Trim$(VTarreglo2(2)) = "[L:]1" Then
          MsgBox "La Conexión se ha restablecido con el Servidor Central Mensaje del Servidor Administrador"
          FMCerrarFormas
          FMActivaMenu False
          If Not VGOnline% And VGSaip$ = "S" Then
            'Conexión al central
            Select Case FMRecLogin(ServerName$)
            Case True
                VGOnline% = True
            Case Else
                VGOnline% = False
                MsgBox "Falló reconexión automática al Servidor Central. Se procede a desconexión automática", vbOKOnly, "Mensaje del Servidor"
                PMLogOff
                Exit Function
            End Select
          End If
          FPrincipal!pnlTransaccionLine = "ON LINE"
          Exit Function
        End If
      End If ' tipo de mensaje informativo
    
    End If
  End If
End Function

' PROPOSITO: Disparar el stored procedure sp_reclogin para realizar conexión al servidor
'
' ESCRITO POR: Rosa Elena Quintero Villarreal
' FECHA : 26/Ago/1998
'
'
Function FMRecLogin(ByVal parServer As String) As Integer
  Dim VTMensaje As String
  Dim VGTerminal As String
  Dim VTTemporal As Integer
  
  PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerNameLocal$
  PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
  PMPasoValores sqlconn&, "@i_terminal", 0, SQLVARCHAR, VGTerminal$
  PMPasoValores sqlconn&, "@i_office", 0, SQLINT4, VGOficina$
  PMPasoValores sqlconn&, "@i_role", 0, SQLINT1, VGRol$
  PMPasoValores sqlconn&, "@i_campwd", 0, SQLINT1&, "1"
  PMPasoValores sqlconn&, "@o_campwd", 1, SQLINT1&, ""
  If FMTransmitirRPC(sqlconn&, parServer$, "master", "sp_reclogin", False, "El usuario " & VGLogin$ & " se ha registrado") Then
    PMMapeaVariable sqlconn&, VTMensaje$
    PMChequea sqlconn&
    MsgBox VTMensaje$
    
    VTTemporal = FMRetParam(sqlconn&, 1)
    If VTTemporal = "1" Then
        FGenerales.Visible = False
        PMCambioPassword sqlconn&, ServerName$, ServerNameLocal$, VGLogin$, VGFilial, VGOficina
        PMLogOff 'FPrincipal.Desconectar
        Exit Function
    End If

    
    FMRecLogin% = True
  Else
    PMChequea sqlconn&
    FMRecLogin% = False
  End If
End Function

' PROPOSITO: Verificar si exite o no linea con el servidor central y así
'            asignar el nombre de servidor correspondiente
' ESCRITO POR: Rosa Elena Quintero Villarreal
' FECHA : 28/Ago/1998
'

Function FMGetServer() As String
  If VGOnline% = True Then
    FMGetServer = ServerName$
  Else
    FMGetServer = ServerNameLocal$
  End If
End Function

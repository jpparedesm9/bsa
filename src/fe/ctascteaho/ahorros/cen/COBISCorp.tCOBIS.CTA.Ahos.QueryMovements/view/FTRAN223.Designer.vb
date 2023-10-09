Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FTran223Class

#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        InitializemskValor()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
        InitializeOptGeneracion()
    End Sub
    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub
    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _OptGeneracion_0 As System.Windows.Forms.RadioButton
    Private WithEvents _OptGeneracion_1 As System.Windows.Forms.RadioButton
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Public WithEvents FraOpcGen As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Public WithEvents rptCristal_co As COBISCorp.Framework.UI.Components.COBISCrystalReport
    Public WithEvents rptCristal As COBISCorp.Framework.UI.Components.COBISCrystalReport
    Private WithEvents _mskValor_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskValor_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents Lblcli As System.Windows.Forms.Label
    Public WithEvents lbldesalianza As System.Windows.Forms.Label
    Public WithEvents Lblalianza As System.Windows.Forms.Label
    Public WithEvents Label5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
    Public OptGeneracion(1) As System.Windows.Forms.RadioButton
    Public cmdBoton(3) As System.Windows.Forms.Button
    Public lblDescripcion(4) As System.Windows.Forms.Label
    Public lblEtiqueta(6) As System.Windows.Forms.Label
    Public mskValor(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public txtCampo(3) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran223Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me.FraOpcGen = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._OptGeneracion_0 = New System.Windows.Forms.RadioButton()
        Me._OptGeneracion_1 = New System.Windows.Forms.RadioButton()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me.rptCristal_co = New COBISCorp.Framework.UI.Components.COBISCrystalReport()
        Me.rptCristal = New COBISCorp.Framework.UI.Components.COBISCrystalReport()
        Me._mskValor_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskValor_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.Lblcli = New System.Windows.Forms.Label()
        Me.lbldesalianza = New System.Windows.Forms.Label()
        Me.Lblalianza = New System.Windows.Forms.Label()
        Me.Label5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBorrar = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.FraOpcGen, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FraOpcGen.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(159, 129)
        Me._txtCampo_0.MaxLength = 120
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(242, 20)
        Me._txtCampo_0.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        'FraOpcGen
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FraOpcGen, False)
        Me.COBISViewResizer.SetAutoResize(Me.FraOpcGen, False)
        Me.FraOpcGen.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FraOpcGen.Controls.Add(Me._OptGeneracion_0)
        Me.FraOpcGen.Controls.Add(Me._txtCampo_3)
        Me.FraOpcGen.Controls.Add(Me._lblEtiqueta_2)
        Me.FraOpcGen.Controls.Add(Me._OptGeneracion_1)
        Me.FraOpcGen.Controls.Add(Me._lblDescripcion_4)
        Me.COBISStyleProvider.SetControlStyle(Me.FraOpcGen, "Default")
        Me.FraOpcGen.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraOpcGen.ForeColor = System.Drawing.Color.Navy
        Me.FraOpcGen.Location = New System.Drawing.Point(10, 176)
        Me.FraOpcGen.Name = "FraOpcGen"
        Me.COBISResourceProvider.SetResourceID(Me.FraOpcGen, "2310")
        Me.FraOpcGen.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraOpcGen.Size = New System.Drawing.Size(393, 82)
        Me.FraOpcGen.TabIndex = 99
        Me.FraOpcGen.Text = "*Opción de Generación"
        Me.FraOpcGen.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FraOpcGen, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(149, 54)
        Me._txtCampo_3.MaxLength = 2
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(36, 20)
        Me._txtCampo_3.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_OptGeneracion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._OptGeneracion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._OptGeneracion_0, False)
        Me._OptGeneracion_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._OptGeneracion_0, "Default")
        Me._OptGeneracion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptGeneracion_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptGeneracion_0.ForeColor = System.Drawing.Color.Navy
        Me._OptGeneracion_0.Location = New System.Drawing.Point(13, 26)
        Me._OptGeneracion_0.Name = "_OptGeneracion_0"
        Me.COBISResourceProvider.SetResourceID(Me._OptGeneracion_0, "500880")
        Me._OptGeneracion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptGeneracion_0.Size = New System.Drawing.Size(121, 17)
        Me._OptGeneracion_0.TabIndex = 3
        Me._OptGeneracion_0.TabStop = True
        Me._OptGeneracion_0.Text = "*Impresión"
        Me._OptGeneracion_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._OptGeneracion_0, "")
        '
        '_OptGeneracion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._OptGeneracion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._OptGeneracion_1, False)
        Me._OptGeneracion_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._OptGeneracion_1, "Default")
        Me._OptGeneracion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._OptGeneracion_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._OptGeneracion_1.ForeColor = System.Drawing.Color.Navy
        Me._OptGeneracion_1.Location = New System.Drawing.Point(149, 26)
        Me._OptGeneracion_1.Name = "_OptGeneracion_1"
        Me.COBISResourceProvider.SetResourceID(Me._OptGeneracion_1, "9877")
        Me._OptGeneracion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._OptGeneracion_1.Size = New System.Drawing.Size(143, 17)
        Me._OptGeneracion_1.TabIndex = 4
        Me._OptGeneracion_1.TabStop = True
        Me._OptGeneracion_1.Text = "*Correo Electrónico"
        Me._OptGeneracion_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._OptGeneracion_1, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(5, 55)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "2312")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(105, 16)
        Me._lblEtiqueta_2.TabIndex = 99
        Me._lblEtiqueta_2.Text = "*Correo Electrónico:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(186, 54)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(198, 20)
        Me._lblDescripcion_4.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(159, 85)
        Me._txtCampo_1.MaxLength = 2
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_1.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Location = New System.Drawing.Point(159, 107)
        Me._txtCampo_2.MaxLength = 4
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(62, 20)
        Me._txtCampo_2.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        'rptCristal_co
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.rptCristal_co, False)
        Me.COBISViewResizer.SetAutoResize(Me.rptCristal_co, False)
        Me.COBISStyleProvider.SetControlStyle(Me.rptCristal_co, "Default")
        Me.rptCristal_co.CopiesToPrinter = CType(0, Short)
        Me.COBISStyleProvider.SetEnableStyle(Me.rptCristal_co, True)
        Me.rptCristal_co.Location = New System.Drawing.Point(431, 84)
        Me.rptCristal_co.Name = "rptCristal_co"
        Me.rptCristal_co.PrinterName = ""
        Me.rptCristal_co.PrinterStartPage = CType(0, Short)
        Me.rptCristal_co.PrinterStopPage = CType(0, Short)
        Me.rptCristal_co.PrintFileName = Nothing
        Me.rptCristal_co.ReportFileName = ""
        Me.rptCristal_co.Size = New System.Drawing.Size(97, 20)
        Me.rptCristal_co.TabIndex = 99
        Me.rptCristal_co.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.rptCristal_co, "")
        Me.rptCristal_co.WindowsTitle = ""
        '
        'rptCristal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.rptCristal, False)
        Me.COBISViewResizer.SetAutoResize(Me.rptCristal, False)
        Me.COBISStyleProvider.SetControlStyle(Me.rptCristal, "Default")
        Me.rptCristal.CopiesToPrinter = CType(0, Short)
        Me.COBISStyleProvider.SetEnableStyle(Me.rptCristal, True)
        Me.rptCristal.Location = New System.Drawing.Point(431, 46)
        Me.rptCristal.Name = "rptCristal"
        Me.rptCristal.PrinterName = ""
        Me.rptCristal.PrinterStartPage = CType(0, Short)
        Me.rptCristal.PrinterStopPage = CType(0, Short)
        Me.rptCristal.PrintFileName = Nothing
        Me.rptCristal.ReportFileName = ""
        Me.rptCristal.Size = New System.Drawing.Size(120, 20)
        Me.rptCristal.TabIndex = 99
        Me.rptCristal.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.rptCristal, "")
        Me.rptCristal.WindowsTitle = ""
        '
        '_mskValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_1, "Default")
        Me._mskValor_1.Enabled = False
        Me._mskValor_1.Length = CType(64, Short)
        Me._mskValor_1.Location = New System.Drawing.Point(353, 3)
        Me._mskValor_1.MaxReal = 3.402823E+38!
        Me._mskValor_1.MinReal = -3.402823E+38!
        Me._mskValor_1.Name = "_mskValor_1"
        Me._mskValor_1.Size = New System.Drawing.Size(10, 20)
        Me._mskValor_1.TabIndex = 99
        Me._mskValor_1.TabStop = False
        Me._mskValor_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_1, "")
        '
        '_mskValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_0, "Default")
        Me._mskValor_0.Enabled = False
        Me._mskValor_0.Length = CType(64, Short)
        Me._mskValor_0.Location = New System.Drawing.Point(363, 3)
        Me._mskValor_0.MaxReal = 3.402823E+38!
        Me._mskValor_0.MinReal = -3.402823E+38!
        Me._mskValor_0.Name = "_mskValor_0"
        Me._mskValor_0.Size = New System.Drawing.Size(10, 20)
        Me._mskValor_0.TabIndex = 99
        Me._mskValor_0.TabStop = False
        Me._mskValor_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_0, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(159, 7)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(147, 20)
        Me.mskCuenta.TabIndex = 99
        Me.mskCuenta.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_cmdBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_0, False)
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_0, True)
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_0, Nothing)
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 165)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 99
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_cmdBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_1, False)
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 216)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 99
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Limpiar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_cmdBoton_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_2, False)
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_2, True)
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 267)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 99
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Salir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_cmdBoton_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_3, False)
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_3, True)
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_3, Nothing)
        Me._cmdBoton_3.Enabled = False
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 114)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 99
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Borrar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me._cmdBoton_3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'Lblcli
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Lblcli, False)
        Me.COBISViewResizer.SetAutoResize(Me.Lblcli, False)
        Me.Lblcli.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Lblcli.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Lblcli, "Default")
        Me.Lblcli.Cursor = System.Windows.Forms.Cursors.Default
        Me.Lblcli.Location = New System.Drawing.Point(375, 7)
        Me.Lblcli.Name = "Lblcli"
        Me.Lblcli.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Lblcli.Size = New System.Drawing.Size(22, 13)
        Me.Lblcli.TabIndex = 99
        Me.Lblcli.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Lblcli, "")
        '
        'lbldesalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lbldesalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.lbldesalianza, False)
        Me.lbldesalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lbldesalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lbldesalianza, "Default")
        Me.lbldesalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.lbldesalianza.Location = New System.Drawing.Point(225, 151)
        Me.lbldesalianza.Name = "lbldesalianza"
        Me.lbldesalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lbldesalianza.Size = New System.Drawing.Size(175, 20)
        Me.lbldesalianza.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lbldesalianza, "")
        '
        'Lblalianza
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Lblalianza, False)
        Me.COBISViewResizer.SetAutoResize(Me.Lblalianza, False)
        Me.Lblalianza.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Lblalianza.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.Lblalianza, "Default")
        Me.Lblalianza.Cursor = System.Windows.Forms.Cursors.Default
        Me.Lblalianza.Location = New System.Drawing.Point(159, 151)
        Me.Lblalianza.Name = "Lblalianza"
        Me.Lblalianza.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Lblalianza.Size = New System.Drawing.Size(62, 20)
        Me.Lblalianza.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Lblalianza, "")
        '
        'Label5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label5, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label5, False)
        Me.Label5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label5, "Default")
        Me.Label5.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Label5.ForeColor = System.Drawing.Color.Navy
        Me.Label5.Location = New System.Drawing.Point(10, 154)
        Me.Label5.Name = "Label5"
        Me.COBISResourceProvider.SetResourceID(Me.Label5, "2309")
        Me.Label5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label5.Size = New System.Drawing.Size(76, 15)
        Me.Label5.TabIndex = 99
        Me.Label5.Text = "*Alianza:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label5, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 132)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "9913")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(76, 15)
        Me._lblEtiqueta_1.TabIndex = 99
        Me._lblEtiqueta_1.Text = "*Concepto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Enabled = False
        Me._lblDescripcion_3.Location = New System.Drawing.Point(371, 108)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(26, 19)
        Me._lblDescripcion_3.TabIndex = 99
        Me._lblDescripcion_3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Enabled = False
        Me._lblDescripcion_2.Location = New System.Drawing.Point(339, 109)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(26, 19)
        Me._lblDescripcion_2.TabIndex = 99
        Me._lblDescripcion_2.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(225, 85)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(176, 20)
        Me._lblDescripcion_1.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 30)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "9492")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(142, 15)
        Me._lblEtiqueta_6.TabIndex = 99
        Me._lblEtiqueta_6.Text = "*Nombre de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(10, 88)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "501882")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(49, 15)
        Me._lblEtiqueta_5.TabIndex = 99
        Me._lblEtiqueta_5.Text = "*Mes:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501874")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(143, 15)
        Me._lblEtiqueta_0.TabIndex = 99
        Me._lblEtiqueta_0.Text = "*No. de cuenta ahorros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(159, 29)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(242, 54)
        Me._lblDescripcion_0.TabIndex = 99
        Me._lblDescripcion_0.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 110)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "2308")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(49, 15)
        Me._lblEtiqueta_3.TabIndex = 99
        Me._lblEtiqueta_3.Text = "*Año:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._txtCampo_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_3)
        Me.PFormas.Controls.Add(Me.FraOpcGen)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.PFormas.Controls.Add(Me._txtCampo_1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_5)
        Me.PFormas.Controls.Add(Me._txtCampo_2)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._lblDescripcion_2)
        Me.PFormas.Controls.Add(Me._mskValor_1)
        Me.PFormas.Controls.Add(Me._lblDescripcion_3)
        Me.PFormas.Controls.Add(Me._mskValor_0)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me.Label5)
        Me.PFormas.Controls.Add(Me.Lblalianza)
        Me.PFormas.Controls.Add(Me.lbldesalianza)
        Me.PFormas.Controls.Add(Me.Lblcli)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(410, 264)
        Me.PFormas.TabIndex = 99
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBorrar, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(428, 25)
        Me.TSBotones.TabIndex = 99
        Me.TSBotones.TabStop = True
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBorrar
        '
        Me.TSBBorrar.ForeColor = System.Drawing.Color.Black
        Me.TSBBorrar.Image = CType(resources.GetObject("TSBBorrar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBorrar, "2006")
        Me.TSBBorrar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBorrar.Name = "TSBBorrar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBorrar, "2029")
        Me.TSBBorrar.Size = New System.Drawing.Size(64, 22)
        Me.TSBBorrar.Text = "*&Borrar"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FTran223Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me.rptCristal_co)
        Me.Controls.Add(Me.rptCristal)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(83, 143)
        Me.Name = "FTran223Class"
        Me.COBISResourceProvider.SetResourceID(Me, "9916")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(428, 309)
        Me.Tag = "1048"
        Me.Text = "*Solicitud de Estado de Cuenta de Ahorros sin Costo"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.FraOpcGen, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FraOpcGen.ResumeLayout(False)
        Me.FraOpcGen.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(2) = _txtCampo_2
    End Sub
    Sub InitializemskValor()
        Me.mskValor(1) = _mskValor_1
        Me.mskValor(0) = _mskValor_0
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(3) = _lblEtiqueta_3
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub
    Sub InitializeOptGeneracion()
        Me.OptGeneracion(0) = _OptGeneracion_0
        Me.OptGeneracion(1) = _OptGeneracion_1
    End Sub

    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBorrar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class



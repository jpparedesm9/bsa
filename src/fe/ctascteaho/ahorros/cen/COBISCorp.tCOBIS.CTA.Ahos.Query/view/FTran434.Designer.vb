Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class Ftran434Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializetxtCampo()
        Initializelblpuntos()
        Initializelblproducto()
        Initializelblplazoacum()
        Initializelblplazo()
        Initializelbldiasmora()
        Initializelblcuota()
        Initializelblcategoria()
        InitializelblPeriodicidad()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
        InitializeMskValor()
        'InitializeLine1()
        InitializeLblmontofin()
        InitializeLabel2()
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
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Public WithEvents txtPlazo As System.Windows.Forms.TextBox
    Private WithEvents _MskValor_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents mskMonto As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblplazoacum_9 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblcategoria_2 As System.Windows.Forms.Label
    Private WithEvents _lbldiasmora_4 As System.Windows.Forms.Label
    Private WithEvents _lblPeriodicidad_3 As System.Windows.Forms.Label
    Private WithEvents _lblproducto_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _Label2_0 As System.Windows.Forms.Label
    Private WithEvents _Lblmontofin_8 As System.Windows.Forms.Label
    Private WithEvents _lblpuntos_5 As System.Windows.Forms.Label
    Private WithEvents _lblcuota_7 As System.Windows.Forms.Label
    Private WithEvents _lblplazo_6 As System.Windows.Forms.Label
    Public WithEvents fraAtributo As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents grdCabecera As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents rptReporte As COBISCorp.Framework.UI.Components.COBISCrystalReport
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_5 As System.Windows.Forms.Label
    Public Label2(0) As System.Windows.Forms.Label
    Public Lblmontofin(8) As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
    Public MskValor(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public lblDescripcion(5) As System.Windows.Forms.Label
    Public lblEtiqueta(6) As System.Windows.Forms.Label
    Public lblPeriodicidad(3) As System.Windows.Forms.Label
    Public lblcategoria(2) As System.Windows.Forms.Label
    Public lblcuota(7) As System.Windows.Forms.Label
    Public lbldiasmora(4) As System.Windows.Forms.Label
    Public lblplazo(6) As System.Windows.Forms.Label
    Public lblplazoacum(9) As System.Windows.Forms.Label
    Public lblproducto(1) As System.Windows.Forms.Label
    Public lblpuntos(5) As System.Windows.Forms.Label
    Public txtCampo(4) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Ftran434Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.fraAtributo = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me.txtPlazo = New System.Windows.Forms.TextBox()
        Me._MskValor_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mskMonto = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lbldiasmora_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblplazo_6 = New System.Windows.Forms.Label()
        Me._lblplazoacum_9 = New System.Windows.Forms.Label()
        Me._lblcategoria_2 = New System.Windows.Forms.Label()
        Me._lblPeriodicidad_3 = New System.Windows.Forms.Label()
        Me._lblproducto_1 = New System.Windows.Forms.Label()
        Me._Lblmontofin_8 = New System.Windows.Forms.Label()
        Me._lblpuntos_5 = New System.Windows.Forms.Label()
        Me._lblcuota_7 = New System.Windows.Forms.Label()
        Me._Label2_0 = New System.Windows.Forms.Label()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.grdCabecera = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.rptReporte = New COBISCorp.Framework.UI.Components.COBISCrystalReport()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_5 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBAceptar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCancelar = New System.Windows.Forms.ToolStripButton()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.fraAtributo, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraAtributo.SuspendLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdCabecera, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        'fraAtributo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraAtributo, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraAtributo, False)
        Me.fraAtributo.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraAtributo.Controls.Add(Me._txtCampo_4)
        Me.fraAtributo.Controls.Add(Me._txtCampo_3)
        Me.fraAtributo.Controls.Add(Me._txtCampo_1)
        Me.fraAtributo.Controls.Add(Me._txtCampo_0)
        Me.fraAtributo.Controls.Add(Me.txtPlazo)
        Me.fraAtributo.Controls.Add(Me._MskValor_1)
        Me.fraAtributo.Controls.Add(Me.mskMonto)
        Me.fraAtributo.Controls.Add(Me._lblDescripcion_4)
        Me.fraAtributo.Controls.Add(Me._lblDescripcion_3)
        Me.fraAtributo.Controls.Add(Me._lblEtiqueta_4)
        Me.fraAtributo.Controls.Add(Me._lblEtiqueta_3)
        Me.fraAtributo.Controls.Add(Me._lblDescripcion_1)
        Me.fraAtributo.Controls.Add(Me._lbldiasmora_4)
        Me.fraAtributo.Controls.Add(Me._lblDescripcion_2)
        Me.fraAtributo.Controls.Add(Me._lblDescripcion_0)
        Me.fraAtributo.Controls.Add(Me._lblplazo_6)
        Me.fraAtributo.Controls.Add(Me._lblplazoacum_9)
        Me.fraAtributo.Controls.Add(Me._lblcategoria_2)
        Me.fraAtributo.Controls.Add(Me._lblPeriodicidad_3)
        Me.fraAtributo.Controls.Add(Me._lblproducto_1)
        Me.fraAtributo.Controls.Add(Me._Lblmontofin_8)
        Me.fraAtributo.Controls.Add(Me._lblpuntos_5)
        Me.fraAtributo.Controls.Add(Me._lblcuota_7)
        Me.COBISStyleProvider.SetControlStyle(Me.fraAtributo, "Default")
        Me.fraAtributo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fraAtributo.ForeColor = System.Drawing.Color.Navy
        Me.fraAtributo.Location = New System.Drawing.Point(6, 59)
        Me.fraAtributo.Name = "fraAtributo"
        Me.COBISResourceProvider.SetResourceID(Me.fraAtributo, "2430")
        Me.fraAtributo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraAtributo.Size = New System.Drawing.Size(524, 188)
        Me.fraAtributo.TabIndex = 2
        Me.fraAtributo.Text = "*Parametros Cuenta Categoria  Especial :"
        Me.fraAtributo.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraAtributo, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Enabled = False
        Me._txtCampo_4.Location = New System.Drawing.Point(145, 68)
        Me._txtCampo_4.MaxLength = 4
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_4.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Enabled = False
        Me._txtCampo_3.Location = New System.Drawing.Point(145, 91)
        Me._txtCampo_3.MaxLength = 4
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_3.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Enabled = False
        Me._txtCampo_1.Location = New System.Drawing.Point(145, 45)
        Me._txtCampo_1.MaxLength = 4
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_1.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Enabled = False
        Me._txtCampo_0.Location = New System.Drawing.Point(145, 22)
        Me._txtCampo_0.MaxLength = 4
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_0.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        'txtPlazo
        '
        Me.txtPlazo.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtPlazo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtPlazo, False)
        Me.txtPlazo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtPlazo, "Default")
        Me.txtPlazo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtPlazo.Location = New System.Drawing.Point(357, 91)
        Me.txtPlazo.MaxLength = 3
        Me.txtPlazo.Name = "txtPlazo"
        Me.txtPlazo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtPlazo.Size = New System.Drawing.Size(69, 20)
        Me.txtPlazo.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtPlazo, "")
        '
        '_MskValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._MskValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._MskValor_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._MskValor_1, "Default")
        Me._MskValor_1.Enabled = False
        Me._MskValor_1.Length = CType(64, Short)
        Me._MskValor_1.Location = New System.Drawing.Point(145, 137)
        Me._MskValor_1.MaxReal = 3.402823E+38!
        Me._MskValor_1.MinReal = -3.402823E+38!
        Me._MskValor_1.Name = "_MskValor_1"
        Me._MskValor_1.Size = New System.Drawing.Size(159, 20)
        Me._MskValor_1.TabIndex = 9
        Me._MskValor_1.Text = "#,##0.00"
        Me._MskValor_1.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me._MskValor_1, "")
        '
        'mskMonto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskMonto, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskMonto, False)
        Me.mskMonto.BackColor = System.Drawing.SystemColors.Window
        Me.mskMonto.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskMonto, "Default")
        Me.mskMonto.DecimalPlaces = 2
        Me.mskMonto.Location = New System.Drawing.Point(145, 114)
        Me.mskMonto.MaxReal = 3.4E+38!
        Me.mskMonto.MinReal = 0.0!
        Me.mskMonto.Name = "mskMonto"
        Me.mskMonto.Separator = True
        Me.mskMonto.Size = New System.Drawing.Size(159, 20)
        Me.mskMonto.TabIndex = 8
        Me.mskMonto.Tag = "7"
        Me.mskMonto.Text = "0.00"
        Me.mskMonto.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.mskMonto.ValueDouble = 0.0R
        Me.mskMonto.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskMonto, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(145, 160)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(65, 20)
        Me._lblDescripcion_4.TabIndex = 10
        Me._lblDescripcion_4.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(357, 158)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(69, 20)
        Me._lblDescripcion_3.TabIndex = 11
        Me._lblDescripcion_3.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblEtiqueta_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(456, 114)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(57, 20)
        Me._lblEtiqueta_4.TabIndex = 26
        Me._lblEtiqueta_4.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblEtiqueta_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(456, 137)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(57, 20)
        Me._lblEtiqueta_3.TabIndex = 25
        Me._lblEtiqueta_3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(213, 45)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(300, 20)
        Me._lblDescripcion_1.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lbldiasmora_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lbldiasmora_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lbldiasmora_4, False)
        Me._lbldiasmora_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lbldiasmora_4, "Default")
        Me._lbldiasmora_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lbldiasmora_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lbldiasmora_4.ForeColor = System.Drawing.Color.Navy
        Me._lbldiasmora_4.Location = New System.Drawing.Point(216, 161)
        Me._lbldiasmora_4.Name = "_lbldiasmora_4"
        Me.COBISResourceProvider.SetResourceID(Me._lbldiasmora_4, "2436")
        Me._lbldiasmora_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lbldiasmora_4.Size = New System.Drawing.Size(158, 14)
        Me._lbldiasmora_4.TabIndex = 23
        Me._lbldiasmora_4.Text = "*Periodos Incumplidos:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lbldiasmora_4, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(213, 68)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(300, 20)
        Me._lblDescripcion_2.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(213, 22)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(300, 20)
        Me._lblDescripcion_0.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblplazo_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblplazo_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblplazo_6, False)
        Me._lblplazo_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblplazo_6, "Default")
        Me._lblplazo_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblplazo_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblplazo_6.ForeColor = System.Drawing.Color.Navy
        Me._lblplazo_6.Location = New System.Drawing.Point(241, 94)
        Me._lblplazo_6.Name = "_lblplazo_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblplazo_6, "2435")
        Me._lblplazo_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblplazo_6.Size = New System.Drawing.Size(110, 14)
        Me._lblplazo_6.TabIndex = 17
        Me._lblplazo_6.Text = "*Meses Pactados:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblplazo_6, "")
        '
        '_lblplazoacum_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblplazoacum_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblplazoacum_9, False)
        Me._lblplazoacum_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblplazoacum_9, "Default")
        Me._lblplazoacum_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblplazoacum_9.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblplazoacum_9.ForeColor = System.Drawing.Color.Navy
        Me._lblplazoacum_9.Location = New System.Drawing.Point(10, 164)
        Me._lblplazoacum_9.Name = "_lblplazoacum_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblplazoacum_9, "2434")
        Me._lblplazoacum_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblplazoacum_9.Size = New System.Drawing.Size(141, 14)
        Me._lblplazoacum_9.TabIndex = 27
        Me._lblplazoacum_9.Text = "*Meses Transcurridos:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblplazoacum_9, "")
        '
        '_lblcategoria_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblcategoria_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblcategoria_2, False)
        Me._lblcategoria_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblcategoria_2, "Default")
        Me._lblcategoria_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblcategoria_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblcategoria_2.ForeColor = System.Drawing.Color.Navy
        Me._lblcategoria_2.Location = New System.Drawing.Point(10, 48)
        Me._lblcategoria_2.Name = "_lblcategoria_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblcategoria_2, "501177")
        Me._lblcategoria_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblcategoria_2.Size = New System.Drawing.Size(141, 14)
        Me._lblcategoria_2.TabIndex = 24
        Me._lblcategoria_2.Text = "*Categoria :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblcategoria_2, "")
        '
        '_lblPeriodicidad_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblPeriodicidad_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblPeriodicidad_3, False)
        Me._lblPeriodicidad_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblPeriodicidad_3, "Default")
        Me._lblPeriodicidad_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblPeriodicidad_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblPeriodicidad_3.ForeColor = System.Drawing.Color.Navy
        Me._lblPeriodicidad_3.Location = New System.Drawing.Point(10, 71)
        Me._lblPeriodicidad_3.Name = "_lblPeriodicidad_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblPeriodicidad_3, "5088")
        Me._lblPeriodicidad_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblPeriodicidad_3.Size = New System.Drawing.Size(141, 14)
        Me._lblPeriodicidad_3.TabIndex = 22
        Me._lblPeriodicidad_3.Text = "*Periodicidad :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblPeriodicidad_3, "")
        '
        '_lblproducto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblproducto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblproducto_1, False)
        Me._lblproducto_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblproducto_1, "Default")
        Me._lblproducto_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblproducto_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblproducto_1.ForeColor = System.Drawing.Color.Navy
        Me._lblproducto_1.Location = New System.Drawing.Point(10, 25)
        Me._lblproducto_1.Name = "_lblproducto_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblproducto_1, "5048")
        Me._lblproducto_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblproducto_1.Size = New System.Drawing.Size(141, 14)
        Me._lblproducto_1.TabIndex = 21
        Me._lblproducto_1.Text = "*Producto :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblproducto_1, "")
        '
        '_Lblmontofin_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Lblmontofin_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._Lblmontofin_8, False)
        Me._Lblmontofin_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._Lblmontofin_8, "Default")
        Me._Lblmontofin_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lblmontofin_8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Lblmontofin_8.ForeColor = System.Drawing.Color.Navy
        Me._Lblmontofin_8.Location = New System.Drawing.Point(10, 140)
        Me._Lblmontofin_8.Name = "_Lblmontofin_8"
        Me.COBISResourceProvider.SetResourceID(Me._Lblmontofin_8, "2433")
        Me._Lblmontofin_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lblmontofin_8.Size = New System.Drawing.Size(141, 14)
        Me._Lblmontofin_8.TabIndex = 0
        Me._Lblmontofin_8.Text = "*Monto Final:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Lblmontofin_8, "")
        '
        '_lblpuntos_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblpuntos_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblpuntos_5, False)
        Me._lblpuntos_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblpuntos_5, "Default")
        Me._lblpuntos_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblpuntos_5.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblpuntos_5.ForeColor = System.Drawing.Color.Navy
        Me._lblpuntos_5.Location = New System.Drawing.Point(10, 94)
        Me._lblpuntos_5.Name = "_lblpuntos_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblpuntos_5, "2431")
        Me._lblpuntos_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblpuntos_5.Size = New System.Drawing.Size(141, 14)
        Me._lblpuntos_5.TabIndex = 18
        Me._lblpuntos_5.Text = "*Puntos de Premio :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblpuntos_5, "")
        '
        '_lblcuota_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblcuota_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblcuota_7, False)
        Me._lblcuota_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblcuota_7, "Default")
        Me._lblcuota_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblcuota_7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblcuota_7.ForeColor = System.Drawing.Color.Navy
        Me._lblcuota_7.Location = New System.Drawing.Point(10, 117)
        Me._lblcuota_7.Name = "_lblcuota_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblcuota_7, "2432")
        Me._lblcuota_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblcuota_7.Size = New System.Drawing.Size(141, 14)
        Me._lblcuota_7.TabIndex = 16
        Me._lblcuota_7.Text = "*Valor Cuota :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblcuota_7, "")
        '
        '_Label2_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Label2_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Label2_0, False)
        Me._Label2_0.BackColor = System.Drawing.Color.White
        Me.COBISStyleProvider.SetControlStyle(Me._Label2_0, "Default")
        Me._Label2_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Label2_0.ForeColor = System.Drawing.Color.Black
        Me._Label2_0.Location = New System.Drawing.Point(-100, 123)
        Me._Label2_0.Name = "_Label2_0"
        Me._Label2_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Label2_0.Size = New System.Drawing.Size(36, 20)
        Me._Label2_0.TabIndex = 20
        Me._Label2_0.Text = "Label2"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Label2_0, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 122)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 12
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Aceptar."
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 177)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 13
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Cancelar."
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
        Me._cmdBoton_2.Enabled = False
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 335)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 15
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Salir."
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me._cmdBoton_2.Visible = False
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
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 12)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 11
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Buscar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'grdRegistros
        '
        Me.grdRegistros._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegistros, False)
        Me.grdRegistros.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdRegistros.Clip = ""
        Me.grdRegistros.Col = CType(1, Short)
        Me.grdRegistros.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegistros, "Default")
        Me.grdRegistros.CtlText = ""
        Me.grdRegistros.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRegistros, True)
        Me.grdRegistros.FixedCols = CType(1, Short)
        Me.grdRegistros.FixedRows = CType(1, Short)
        Me.grdRegistros.ForeColor = System.Drawing.Color.Black
        Me.grdRegistros.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRegistros.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRegistros.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegistros.HighLight = True
        Me.grdRegistros.Location = New System.Drawing.Point(3, 16)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(518, 139)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 13
        Me.grdRegistros.TabStop = False
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Enabled = False
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(151, 11)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(147, 20)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_cmdBoton_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_4, False)
        Me._cmdBoton_4.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_4, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_4, True)
        Me._cmdBoton_4.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_4, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_4, Nothing)
        Me._cmdBoton_4.Enabled = False
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 281)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(60, 53)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 14
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Imprimir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me._cmdBoton_4.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'grdCabecera
        '
        Me.grdCabecera._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdCabecera, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdCabecera, False)
        Me.grdCabecera.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdCabecera.Clip = ""
        Me.grdCabecera.Col = CType(1, Short)
        Me.grdCabecera.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdCabecera.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdCabecera.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdCabecera, "Default")
        Me.grdCabecera.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdCabecera, True)
        Me.grdCabecera.FixedCols = CType(1, Short)
        Me.grdCabecera.FixedRows = CType(1, Short)
        Me.grdCabecera.ForeColor = System.Drawing.Color.Black
        Me.grdCabecera.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdCabecera.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdCabecera.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdCabecera.HighLight = True
        Me.grdCabecera.Location = New System.Drawing.Point(8, 161)
        Me.grdCabecera.Name = "grdCabecera"
        Me.grdCabecera.Picture = Nothing
        Me.grdCabecera.Row = CType(1, Short)
        Me.grdCabecera.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdCabecera.Size = New System.Drawing.Size(556, 57)
        Me.grdCabecera.Sort = CType(2, Short)
        Me.grdCabecera.TabIndex = 36
        Me.grdCabecera.TabStop = False
        Me.grdCabecera.TopRow = CType(1, Short)
        Me.grdCabecera.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdCabecera, "")
        '
        'rptReporte
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.rptReporte, False)
        Me.COBISViewResizer.SetAutoResize(Me.rptReporte, False)
        Me.COBISStyleProvider.SetControlStyle(Me.rptReporte, "Default")
        Me.rptReporte.CopiesToPrinter = CType(0, Short)
        Me.COBISStyleProvider.SetEnableStyle(Me.rptReporte, True)
        Me.rptReporte.Location = New System.Drawing.Point(0, 28)
        Me.rptReporte.Name = "rptReporte"
        Me.rptReporte.PrinterName = ""
        Me.rptReporte.PrinterStartPage = CType(0, Short)
        Me.rptReporte.PrinterStopPage = CType(0, Short)
        Me.rptReporte.PrintFileName = Nothing
        Me.rptReporte.ReportFileName = ""
        Me.rptReporte.Size = New System.Drawing.Size(97, 20)
        Me.rptReporte.TabIndex = 37
        Me.COBISViewResizer.SetWidthRelativeTo(Me.rptReporte, "")
        Me.rptReporte.WindowsTitle = ""
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 35)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500108")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(132, 14)
        Me._lblEtiqueta_6.TabIndex = 35
        Me._lblEtiqueta_6.Text = "*Nombre de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
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
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 12)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "501874")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(132, 14)
        Me._lblEtiqueta_1.TabIndex = 34
        Me._lblEtiqueta_1.Text = "*No. de cuenta ahorros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_5, False)
        Me._lblDescripcion_5.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_5.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_5, "Default")
        Me._lblDescripcion_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_5.Location = New System.Drawing.Point(151, 34)
        Me._lblDescripcion_5.Name = "_lblDescripcion_5"
        Me._lblDescripcion_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_5.Size = New System.Drawing.Size(368, 20)
        Me._lblDescripcion_5.TabIndex = 1
        Me._lblDescripcion_5.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_5, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.GroupBox1.Controls.Add(Me.grdCabecera)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(6, 253)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "2437")
        Me.GroupBox1.Size = New System.Drawing.Size(524, 158)
        Me.GroupBox1.TabIndex = 12
        Me.GroupBox1.Text = "*Consulta Plan de Pago :"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.fraAtributo)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_6)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me._lblDescripcion_5)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(539, 424)
        Me.PFormas.TabIndex = 41
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBAceptar, Me.TSBCancelar, Me.TSBImprimir, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(558, 25)
        Me.TSBotones.TabIndex = 42
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Navy
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBAceptar
        '
        Me.TSBAceptar.ForeColor = System.Drawing.Color.Navy
        Me.TSBAceptar.Image = CType(resources.GetObject("TSBAceptar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBAceptar, "2503")
        Me.TSBAceptar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBAceptar.Name = "TSBAceptar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBAceptar, "2011")
        Me.TSBAceptar.Size = New System.Drawing.Size(73, 22)
        Me.TSBAceptar.Text = "*&Aceptar"
        '
        'TSBCancelar
        '
        Me.TSBCancelar.ForeColor = System.Drawing.Color.Navy
        Me.TSBCancelar.Image = CType(resources.GetObject("TSBCancelar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCancelar, "2501")
        Me.TSBCancelar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCancelar.Name = "TSBCancelar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCancelar, "2012")
        Me.TSBCancelar.Size = New System.Drawing.Size(78, 22)
        Me.TSBCancelar.Text = "*&Cancelar"
        '
        'TSBImprimir
        '
        Me.TSBImprimir.ForeColor = System.Drawing.Color.Navy
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.Size = New System.Drawing.Size(78, 22)
        Me.TSBImprimir.Text = "*&Imprimir"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'Ftran434Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._Label2_0)
        Me.Controls.Add(Me.rptReporte)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.SystemColors.WindowText
        Me.Location = New System.Drawing.Point(28, 123)
        Me.Name = "Ftran434Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(558, 463)
        Me.Text = "Parametros Cuentas con Caracteristicas Especiales"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.fraAtributo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraAtributo.ResumeLayout(False)
        Me.fraAtributo.PerformLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdCabecera, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
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
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(0) = _txtCampo_0
    End Sub
    Sub Initializelblpuntos()
        Me.lblpuntos(5) = _lblpuntos_5
    End Sub
    Sub Initializelblproducto()
        Me.lblproducto(1) = _lblproducto_1
    End Sub
    Sub Initializelblplazoacum()
        Me.lblplazoacum(9) = _lblplazoacum_9
    End Sub
    Sub Initializelblplazo()
        Me.lblplazo(6) = _lblplazo_6
    End Sub
    Sub Initializelbldiasmora()
        Me.lbldiasmora(4) = _lbldiasmora_4
    End Sub
    Sub Initializelblcuota()
        Me.lblcuota(7) = _lblcuota_7
    End Sub
    Sub Initializelblcategoria()
        Me.lblcategoria(2) = _lblcategoria_2
    End Sub
    Sub InitializelblPeriodicidad()
        Me.lblPeriodicidad(3) = _lblPeriodicidad_3
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        ' Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(5) = _lblDescripcion_5
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
    End Sub
    Sub InitializeMskValor()
        Me.MskValor(1) = _MskValor_1
    End Sub
    'Sub InitializeLine1()
    '    Me.Line1(0) = _Line1_0
    '    Me.Line1(1) = _Line1_1
    'End Sub
    Sub InitializeLblmontofin()
        Me.Lblmontofin(8) = _Lblmontofin_8
    End Sub
    Sub InitializeLabel2()
        Me.Label2(0) = _Label2_0
    End Sub
    ' Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBAceptar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCancelar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
#End Region
End Class



Imports COBISCorp.tCOBIS.CTA.SharedLibrary

<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FTran2913Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCaucc()
        InitializetxtCauaho()
        InitializetxtCampo()
        InitializeoptOper()
        InitializelblEtiqueta()
        InitializecmdBoton()
        InitializeLblcauho()
        InitializeLblcaucc()
        InitializeFrame4()
        'This form is an MDI child.
        'This code simulates the Compatibility.VB6 
        ' functionality of automatically
        ' loading and showing an MDI
        ' child's parent.


        'The MDI form in the Compatibility.VB6 project had its
        'AutoShowChildren property set to True
        'To simulate the Compatibility.VB6 behavior, we need to
        'automatically Show the form whenever it
        'is loaded.  If you do not want this behavior
        'then delete the following line of code
        'UPGRADE_TODO: (2018) Remove the next line of code to stop form from automatically showing. More Information: http://www.vbtonet.com/ewis/ewi2018.aspx
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
    Public WithEvents txtVigencia As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Public WithEvents CmbPrograma As System.Windows.Forms.ComboBox
    Public WithEvents grdInterfaz As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Public WithEvents FrmInterfaz As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCaucc_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCaucc_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCauaho_1 As System.Windows.Forms.TextBox
    Private WithEvents _txtCauaho_0 As System.Windows.Forms.TextBox
    Public WithEvents chk_ndncaho As System.Windows.Forms.CheckBox
    Public WithEvents chk_ndncc As System.Windows.Forms.CheckBox
    Private WithEvents _Lblcaucc_1 As System.Windows.Forms.Label
    Private WithEvents _Lblcaucc_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _Lblcauho_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _Lblcauho_0 As System.Windows.Forms.Label
    Private WithEvents _Frame4_2 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents chkIva As System.Windows.Forms.CheckBox
    Public WithEvents chkGastoB As System.Windows.Forms.CheckBox
    Public WithEvents mskValor As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _Frame4_0 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _optOper_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optOper_3 As System.Windows.Forms.RadioButton
    Public WithEvents Frame2 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Public WithEvents ChkChequeL As System.Windows.Forms.CheckBox
    Public WithEvents ChkEfectivo As System.Windows.Forms.CheckBox
    Public WithEvents ChkChequeP As System.Windows.Forms.CheckBox
    Public WithEvents Optndnc As System.Windows.Forms.CheckBox
    Private WithEvents _Frame4_1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents lblDescripcion As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Public Frame4(2) As Infragistics.Win.Misc.UltraGroupBox
    Public Lblcaucc(1) As System.Windows.Forms.Label
    Public Lblcauho(1) As System.Windows.Forms.Label
    Public Line1(0) As System.Windows.Forms.Label
    Public cmdBoton(6) As System.Windows.Forms.Button
    Public lblEtiqueta(6) As System.Windows.Forms.Label
    Public optOper(3) As System.Windows.Forms.RadioButton
    Public txtCampo(0) As System.Windows.Forms.TextBox
    Public txtCauaho(1) As System.Windows.Forms.TextBox
    Public txtCaucc(1) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTran2913Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.FrmInterfaz = New Infragistics.Win.Misc.UltraGroupBox()
        Me.txtVigencia = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.CmbPrograma = New System.Windows.Forms.ComboBox()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.grdInterfaz = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._Frame4_2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox4 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCaucc_1 = New System.Windows.Forms.TextBox()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._Lblcauho_1 = New System.Windows.Forms.Label()
        Me._txtCauaho_1 = New System.Windows.Forms.TextBox()
        Me._Lblcaucc_1 = New System.Windows.Forms.Label()
        Me.UltraGroupBox3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._txtCaucc_0 = New System.Windows.Forms.TextBox()
        Me._Lblcauho_0 = New System.Windows.Forms.Label()
        Me._Lblcaucc_0 = New System.Windows.Forms.Label()
        Me._txtCauaho_0 = New System.Windows.Forms.TextBox()
        Me.chk_ndncaho = New System.Windows.Forms.CheckBox()
        Me.chk_ndncc = New System.Windows.Forms.CheckBox()
        Me._Frame4_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.chkIva = New System.Windows.Forms.CheckBox()
        Me.mskValor = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.chkGastoB = New System.Windows.Forms.CheckBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me.Frame2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optOper_2 = New System.Windows.Forms.RadioButton()
        Me._optOper_3 = New System.Windows.Forms.RadioButton()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._Frame4_1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.ChkChequeL = New System.Windows.Forms.CheckBox()
        Me.ChkEfectivo = New System.Windows.Forms.CheckBox()
        Me.ChkChequeP = New System.Windows.Forms.CheckBox()
        Me.Optndnc = New System.Windows.Forms.CheckBox()
        Me.lblDescripcion = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguientes = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.FrmInterfaz, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FrmInterfaz.SuspendLayout()
        CType(Me.grdInterfaz, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._Frame4_2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame4_2.SuspendLayout()
        CType(Me.UltraGroupBox4, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox4.SuspendLayout()
        CType(Me.UltraGroupBox3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox3.SuspendLayout()
        CType(Me._Frame4_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame4_0.SuspendLayout()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame2.SuspendLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._Frame4_1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame4_1.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Pforma.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
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
        'FrmInterfaz
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FrmInterfaz, False)
        Me.COBISViewResizer.SetAutoResize(Me.FrmInterfaz, False)
        Me.FrmInterfaz.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FrmInterfaz.Controls.Add(Me.txtVigencia)
        Me.FrmInterfaz.Controls.Add(Me.CmbPrograma)
        Me.FrmInterfaz.Controls.Add(Me._lblEtiqueta_5)
        Me.FrmInterfaz.Controls.Add(Me._lblEtiqueta_6)
        Me.COBISStyleProvider.SetControlStyle(Me.FrmInterfaz, "Default")
        Me.FrmInterfaz.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.FrmInterfaz.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FrmInterfaz.ForeColor = System.Drawing.Color.Navy
        Me.FrmInterfaz.Location = New System.Drawing.Point(3, 190)
        Me.FrmInterfaz.Name = "FrmInterfaz"
        Me.COBISResourceProvider.SetResourceID(Me.FrmInterfaz, "502724")
        Me.FrmInterfaz.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FrmInterfaz.Size = New System.Drawing.Size(539, 55)
        Me.FrmInterfaz.TabIndex = 24
        Me.FrmInterfaz.Text = " *Interfaz Ordenes Pago/Cobro en Caja"
        Me.FrmInterfaz.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FrmInterfaz, "")
        '
        'txtVigencia
        '
        Me.txtVigencia.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtVigencia, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtVigencia, False)
        Me.txtVigencia.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me.txtVigencia, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtVigencia, True)
        Me.txtVigencia.Error = CType(0, Short)
        Me.txtVigencia.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtVigencia.HelpLine = Nothing
        Me.txtVigencia.Location = New System.Drawing.Point(427, 26)
        Me.txtVigencia.MaxLength = CType(3, Short)
        Me.txtVigencia.MinChar = CType(0, Short)
        Me.txtVigencia.Name = "txtVigencia"
        Me.txtVigencia.Pendiente = Nothing
        Me.txtVigencia.Range = Nothing
        Me.txtVigencia.Size = New System.Drawing.Size(44, 20)
        Me.txtVigencia.TabIndex = 26
        Me.txtVigencia.TableName = Nothing
        Me.txtVigencia.TitleCatalog = Nothing
        Me.txtVigencia.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Smallint
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtVigencia, "")
        '
        'CmbPrograma
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.CmbPrograma, False)
        Me.COBISViewResizer.SetAutoResize(Me.CmbPrograma, False)
        Me.CmbPrograma.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.CmbPrograma, "Default")
        Me.CmbPrograma.Cursor = System.Windows.Forms.Cursors.Default
        Me.CmbPrograma.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.CmbPrograma.ForeColor = System.Drawing.SystemColors.WindowText
        Me.CmbPrograma.Location = New System.Drawing.Point(103, 26)
        Me.CmbPrograma.Name = "CmbPrograma"
        Me.CmbPrograma.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.CmbPrograma.Size = New System.Drawing.Size(187, 21)
        Me.CmbPrograma.TabIndex = 25
        Me.COBISViewResizer.SetWidthRelativeTo(Me.CmbPrograma, "")
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
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(307, 29)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "502726")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(110, 14)
        Me._lblEtiqueta_5.TabIndex = 99
        Me._lblEtiqueta_5.Text = "*Vigencia Orden:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(16, 29)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "502725")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(81, 14)
        Me._lblEtiqueta_6.TabIndex = 99
        Me._lblEtiqueta_6.Text = "*Programa:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'grdInterfaz
        '
        Me.grdInterfaz._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdInterfaz, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdInterfaz, False)
        Me.grdInterfaz.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdInterfaz.Clip = ""
        Me.grdInterfaz.Col = CType(1, Short)
        Me.grdInterfaz.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdInterfaz.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdInterfaz.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdInterfaz, "Default")
        Me.grdInterfaz.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdInterfaz, True)
        Me.grdInterfaz.FixedCols = CType(1, Short)
        Me.grdInterfaz.FixedRows = CType(1, Short)
        Me.grdInterfaz.ForeColor = System.Drawing.Color.Black
        Me.grdInterfaz.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdInterfaz.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdInterfaz.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdInterfaz.HighLight = True
        Me.grdInterfaz.Location = New System.Drawing.Point(201, 120)
        Me.grdInterfaz.Name = "grdInterfaz"
        Me.grdInterfaz.Picture = Nothing
        Me.grdInterfaz.Row = CType(1, Short)
        Me.grdInterfaz.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdInterfaz.Size = New System.Drawing.Size(72, 39)
        Me.grdInterfaz.Sort = CType(2, Short)
        Me.grdInterfaz.TabIndex = 99
        Me.grdInterfaz.TopRow = CType(1, Short)
        Me.grdInterfaz.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdInterfaz, "")
        '
        '_Frame4_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame4_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame4_2, False)
        Me._Frame4_2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame4_2.Controls.Add(Me.UltraGroupBox4)
        Me._Frame4_2.Controls.Add(Me.UltraGroupBox3)
        Me._Frame4_2.Controls.Add(Me.chk_ndncaho)
        Me._Frame4_2.Controls.Add(Me.chk_ndncc)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame4_2, "Default")
        Me._Frame4_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame4_2.ForeColor = System.Drawing.Color.Navy
        Me._Frame4_2.Location = New System.Drawing.Point(141, 85)
        Me._Frame4_2.Name = "_Frame4_2"
        Me.COBISResourceProvider.SetResourceID(Me._Frame4_2, "503364")
        Me._Frame4_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame4_2.Size = New System.Drawing.Size(400, 100)
        Me._Frame4_2.TabIndex = 15
        Me._Frame4_2.Text = "*Causal Nota Débito"
        Me._Frame4_2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame4_2, "")
        '
        'UltraGroupBox4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox4, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox4, False)
        Me.UltraGroupBox4.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox4.Controls.Add(Me._txtCaucc_1)
        Me.UltraGroupBox4.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox4.Controls.Add(Me._Lblcauho_1)
        Me.UltraGroupBox4.Controls.Add(Me._txtCauaho_1)
        Me.UltraGroupBox4.Controls.Add(Me._Lblcaucc_1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox4, "Default")
        Me.UltraGroupBox4.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox4.Location = New System.Drawing.Point(214, 21)
        Me.UltraGroupBox4.Name = "UltraGroupBox4"
        Me.UltraGroupBox4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox4.Size = New System.Drawing.Size(177, 72)
        Me.UltraGroupBox4.TabIndex = 21
        Me.UltraGroupBox4.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox4, "")
        '
        '_txtCaucc_1
        '
        Me._txtCaucc_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCaucc_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCaucc_1, False)
        Me._txtCaucc_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCaucc_1, "Default")
        Me._txtCaucc_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCaucc_1.Location = New System.Drawing.Point(6, 47)
        Me._txtCaucc_1.MaxLength = 5
        Me._txtCaucc_1.Name = "_txtCaucc_1"
        Me._txtCaucc_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCaucc_1.Size = New System.Drawing.Size(35, 20)
        Me._txtCaucc_1.TabIndex = 23
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCaucc_1, "")
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
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(6, 4)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "502721")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(103, 12)
        Me._lblEtiqueta_3.TabIndex = 99
        Me._lblEtiqueta_3.Text = "*Causal  Rev"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_Lblcauho_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Lblcauho_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Lblcauho_1, False)
        Me._Lblcauho_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Lblcauho_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._Lblcauho_1, "Default")
        Me._Lblcauho_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lblcauho_1.Location = New System.Drawing.Point(45, 21)
        Me._Lblcauho_1.Name = "_Lblcauho_1"
        Me._Lblcauho_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lblcauho_1.Size = New System.Drawing.Size(125, 19)
        Me._Lblcauho_1.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Lblcauho_1, "")
        '
        '_txtCauaho_1
        '
        Me._txtCauaho_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCauaho_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCauaho_1, False)
        Me._txtCauaho_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCauaho_1, "Default")
        Me._txtCauaho_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCauaho_1.Location = New System.Drawing.Point(6, 20)
        Me._txtCauaho_1.MaxLength = 5
        Me._txtCauaho_1.Name = "_txtCauaho_1"
        Me._txtCauaho_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCauaho_1.Size = New System.Drawing.Size(35, 20)
        Me._txtCauaho_1.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCauaho_1, "")
        '
        '_Lblcaucc_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Lblcaucc_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Lblcaucc_1, False)
        Me._Lblcaucc_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Lblcaucc_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._Lblcaucc_1, "Default")
        Me._Lblcaucc_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lblcaucc_1.Location = New System.Drawing.Point(45, 48)
        Me._Lblcaucc_1.Name = "_Lblcaucc_1"
        Me._Lblcaucc_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lblcaucc_1.Size = New System.Drawing.Size(125, 19)
        Me._Lblcaucc_1.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Lblcaucc_1, "")
        '
        'UltraGroupBox3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox3, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox3, False)
        Me.UltraGroupBox3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox3.Controls.Add(Me._lblEtiqueta_1)
        Me.UltraGroupBox3.Controls.Add(Me._txtCaucc_0)
        Me.UltraGroupBox3.Controls.Add(Me._Lblcauho_0)
        Me.UltraGroupBox3.Controls.Add(Me._Lblcaucc_0)
        Me.UltraGroupBox3.Controls.Add(Me._txtCauaho_0)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox3, "Default")
        Me.UltraGroupBox3.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox3.Location = New System.Drawing.Point(49, 21)
        Me.UltraGroupBox3.Name = "UltraGroupBox3"
        Me.UltraGroupBox3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox3.Size = New System.Drawing.Size(165, 72)
        Me.UltraGroupBox3.TabIndex = 18
        Me.UltraGroupBox3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox3, "")
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
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(6, 5)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "500674")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(74, 12)
        Me._lblEtiqueta_1.TabIndex = 99
        Me._lblEtiqueta_1.Text = "*Causal"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_txtCaucc_0
        '
        Me._txtCaucc_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCaucc_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCaucc_0, False)
        Me._txtCaucc_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCaucc_0, "Default")
        Me._txtCaucc_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCaucc_0.Location = New System.Drawing.Point(6, 47)
        Me._txtCaucc_0.MaxLength = 5
        Me._txtCaucc_0.Name = "_txtCaucc_0"
        Me._txtCaucc_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCaucc_0.Size = New System.Drawing.Size(35, 20)
        Me._txtCaucc_0.TabIndex = 20
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCaucc_0, "")
        '
        '_Lblcauho_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Lblcauho_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Lblcauho_0, False)
        Me._Lblcauho_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Lblcauho_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._Lblcauho_0, "Default")
        Me._Lblcauho_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lblcauho_0.Location = New System.Drawing.Point(46, 22)
        Me._Lblcauho_0.Name = "_Lblcauho_0"
        Me._Lblcauho_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lblcauho_0.Size = New System.Drawing.Size(113, 19)
        Me._Lblcauho_0.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Lblcauho_0, "")
        '
        '_Lblcaucc_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Lblcaucc_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Lblcaucc_0, False)
        Me._Lblcaucc_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Lblcaucc_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._Lblcaucc_0, "Default")
        Me._Lblcaucc_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._Lblcaucc_0.Location = New System.Drawing.Point(46, 48)
        Me._Lblcaucc_0.Name = "_Lblcaucc_0"
        Me._Lblcaucc_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Lblcaucc_0.Size = New System.Drawing.Size(113, 19)
        Me._Lblcaucc_0.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Lblcaucc_0, "")
        '
        '_txtCauaho_0
        '
        Me._txtCauaho_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCauaho_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCauaho_0, False)
        Me._txtCauaho_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCauaho_0, "Default")
        Me._txtCauaho_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCauaho_0.Location = New System.Drawing.Point(6, 21)
        Me._txtCauaho_0.MaxLength = 5
        Me._txtCauaho_0.Name = "_txtCauaho_0"
        Me._txtCauaho_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCauaho_0.Size = New System.Drawing.Size(35, 20)
        Me._txtCauaho_0.TabIndex = 19
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCauaho_0, "")
        '
        'chk_ndncaho
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chk_ndncaho, False)
        Me.COBISViewResizer.SetAutoResize(Me.chk_ndncaho, False)
        Me.chk_ndncaho.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chk_ndncaho, "Default")
        Me.chk_ndncaho.Cursor = System.Windows.Forms.Cursors.Default
        Me.chk_ndncaho.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chk_ndncaho.ForeColor = System.Drawing.Color.Navy
        Me.chk_ndncaho.Location = New System.Drawing.Point(12, 43)
        Me.chk_ndncaho.Name = "chk_ndncaho"
        Me.chk_ndncaho.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chk_ndncaho.Size = New System.Drawing.Size(39, 16)
        Me.chk_ndncaho.TabIndex = 16
        Me.chk_ndncaho.Tag = "2747"
        Me.chk_ndncaho.Text = "AH"
        Me.chk_ndncaho.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chk_ndncaho, "")
        '
        'chk_ndncc
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chk_ndncc, False)
        Me.COBISViewResizer.SetAutoResize(Me.chk_ndncc, False)
        Me.chk_ndncc.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chk_ndncc, "Default")
        Me.chk_ndncc.Cursor = System.Windows.Forms.Cursors.Default
        Me.chk_ndncc.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chk_ndncc.ForeColor = System.Drawing.Color.Navy
        Me.chk_ndncc.Location = New System.Drawing.Point(12, 71)
        Me.chk_ndncc.Name = "chk_ndncc"
        Me.chk_ndncc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chk_ndncc.Size = New System.Drawing.Size(37, 16)
        Me.chk_ndncc.TabIndex = 17
        Me.chk_ndncc.Tag = "2747"
        Me.chk_ndncc.Text = "CC"
        Me.chk_ndncc.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chk_ndncc, "")
        '
        '_Frame4_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame4_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame4_0, False)
        Me._Frame4_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame4_0.Controls.Add(Me.chkIva)
        Me._Frame4_0.Controls.Add(Me.mskValor)
        Me._Frame4_0.Controls.Add(Me.chkGastoB)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame4_0, "Default")
        Me._Frame4_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame4_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame4_0.Location = New System.Drawing.Point(393, 3)
        Me._Frame4_0.Name = "_Frame4_0"
        Me.COBISResourceProvider.SetResourceID(Me._Frame4_0, "502716")
        Me._Frame4_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame4_0.Size = New System.Drawing.Size(146, 81)
        Me._Frame4_0.TabIndex = 6
        Me._Frame4_0.Text = "*Costo del Servicio"
        Me._Frame4_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame4_0, "")
        '
        'chkIva
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkIva, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkIva, False)
        Me.chkIva.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkIva, "Default")
        Me.chkIva.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkIva.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkIva.ForeColor = System.Drawing.Color.Navy
        Me.chkIva.Location = New System.Drawing.Point(12, 40)
        Me.chkIva.Name = "chkIva"
        Me.COBISResourceProvider.SetResourceID(Me.chkIva, "503067")
        Me.chkIva.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkIva.Size = New System.Drawing.Size(111, 16)
        Me.chkIva.TabIndex = 8
        Me.chkIva.Text = "*Cobro de IVA"
        Me.chkIva.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkIva, "")
        '
        'mskValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValor, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskValor, "Default")
        Me.mskValor.Length = CType(11, Short)
        Me.mskValor.Location = New System.Drawing.Point(11, 18)
        Me.mskValor.MaxReal = 1.0E+8!
        Me.mskValor.MinReal = 0.0!
        Me.mskValor.Name = "mskValor"
        Me.mskValor.RightToLeft = System.Windows.Forms.RightToLeft.Yes
        Me.mskValor.Size = New System.Drawing.Size(123, 20)
        Me.mskValor.TabIndex = 7
        Me.mskValor.Text = "#,##0.00"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValor, "")
        '
        'chkGastoB
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkGastoB, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkGastoB, False)
        Me.chkGastoB.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkGastoB, "Default")
        Me.chkGastoB.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkGastoB.Enabled = False
        Me.chkGastoB.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkGastoB.ForeColor = System.Drawing.Color.Navy
        Me.chkGastoB.Location = New System.Drawing.Point(12, 57)
        Me.chkGastoB.Name = "chkGastoB"
        Me.COBISResourceProvider.SetResourceID(Me.chkGastoB, "503068")
        Me.chkGastoB.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkGastoB.Size = New System.Drawing.Size(122, 16)
        Me.chkGastoB.TabIndex = 9
        Me.chkGastoB.Text = "*Gasto del Banco"
        Me.chkGastoB.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkGastoB, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(88, 45)
        Me._txtCampo_0.MaxLength = 5
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(43, 20)
        Me._txtCampo_0.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        'Frame2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame2, False)
        Me.Frame2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame2.Controls.Add(Me._optOper_2)
        Me.Frame2.Controls.Add(Me._optOper_3)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame2, "Default")
        Me.Frame2.ForeColor = System.Drawing.Color.Navy
        Me.Frame2.Location = New System.Drawing.Point(88, 9)
        Me.Frame2.Name = "Frame2"
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(278, 30)
        Me.Frame2.TabIndex = 2
        Me.Frame2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame2, "")
        '
        '_optOper_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOper_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOper_2, False)
        Me._optOper_2.BackColor = System.Drawing.Color.Transparent
        Me._optOper_2.CheckAlign = System.Drawing.ContentAlignment.MiddleRight
        Me._optOper_2.Checked = True
        Me.COBISStyleProvider.SetControlStyle(Me._optOper_2, "Default")
        Me._optOper_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOper_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optOper_2.ForeColor = System.Drawing.Color.Navy
        Me._optOper_2.Location = New System.Drawing.Point(15, 6)
        Me._optOper_2.Name = "_optOper_2"
        Me.COBISResourceProvider.SetResourceID(Me._optOper_2, "502714")
        Me._optOper_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOper_2.Size = New System.Drawing.Size(114, 18)
        Me._optOper_2.TabIndex = 3
        Me._optOper_2.TabStop = True
        Me._optOper_2.Tag = "S"
        Me._optOper_2.Text = "*Otros Ingresos:"
        Me._optOper_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOper_2, "")
        '
        '_optOper_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOper_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOper_3, False)
        Me._optOper_3.BackColor = System.Drawing.Color.Transparent
        Me._optOper_3.CheckAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.COBISStyleProvider.SetControlStyle(Me._optOper_3, "Default")
        Me._optOper_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOper_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optOper_3.ForeColor = System.Drawing.Color.Navy
        Me._optOper_3.Location = New System.Drawing.Point(147, 6)
        Me._optOper_3.Name = "_optOper_3"
        Me.COBISResourceProvider.SetResourceID(Me._optOper_3, "502715")
        Me._optOper_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOper_3.Size = New System.Drawing.Size(114, 18)
        Me._optOper_3.TabIndex = 4
        Me._optOper_3.Tag = "S"
        Me._optOper_3.Text = "*Otros Egresos:"
        Me._optOper_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOper_3, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-100, 368)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 49)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 99
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Salir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_cmdBoton_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_6, False)
        Me._cmdBoton_6.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_6, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_6, True)
        Me._cmdBoton_6.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_6, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_6, Nothing)
        Me._cmdBoton_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_6.Location = New System.Drawing.Point(-100, 57)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 99
        Me._cmdBoton_6.TabStop = False
        Me._cmdBoton_6.Text = "*&Buscar"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
        '
        '_cmdBoton_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_5, False)
        Me._cmdBoton_5.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_5, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_5, True)
        Me._cmdBoton_5.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_5, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_5, Nothing)
        Me._cmdBoton_5.Enabled = False
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Location = New System.Drawing.Point(-100, 107)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 99
        Me._cmdBoton_5.TabStop = False
        Me._cmdBoton_5.Text = "*Siguien&tes"
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-100, 257)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 99
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Tag = "2516"
        Me._cmdBoton_2.Text = "*&Eliminar"
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
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-100, 157)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 49)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 99
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Tag = "2548"
        Me._cmdBoton_3.Text = "*&Crear"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_4.Location = New System.Drawing.Point(-100, 211)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 49)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 99
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Tag = "2549"
        Me._cmdBoton_4.Text = "*&Actualizar"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me.grdRegistros.Cols = 4
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
        Me.grdRegistros.Size = New System.Drawing.Size(539, 139)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 28
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-100, 318)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 49)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 99
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*&Limpiar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_Frame4_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame4_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame4_1, False)
        Me._Frame4_1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame4_1.Controls.Add(Me.ChkChequeL)
        Me._Frame4_1.Controls.Add(Me.ChkEfectivo)
        Me._Frame4_1.Controls.Add(Me.ChkChequeP)
        Me._Frame4_1.Controls.Add(Me.Optndnc)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame4_1, "Default")
        Me._Frame4_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame4_1.ForeColor = System.Drawing.Color.Navy
        Me._Frame4_1.Location = New System.Drawing.Point(6, 85)
        Me._Frame4_1.Name = "_Frame4_1"
        Me.COBISResourceProvider.SetResourceID(Me._Frame4_1, "502719")
        Me._Frame4_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame4_1.Size = New System.Drawing.Size(129, 100)
        Me._Frame4_1.TabIndex = 10
        Me._Frame4_1.Text = "*Medio de Pago"
        Me._Frame4_1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame4_1, "")
        '
        'ChkChequeL
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.ChkChequeL, False)
        Me.COBISViewResizer.SetAutoResize(Me.ChkChequeL, False)
        Me.ChkChequeL.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.ChkChequeL, "Default")
        Me.ChkChequeL.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkChequeL.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkChequeL.ForeColor = System.Drawing.Color.Navy
        Me.ChkChequeL.Location = New System.Drawing.Point(11, 56)
        Me.ChkChequeL.Name = "ChkChequeL"
        Me.COBISResourceProvider.SetResourceID(Me.ChkChequeL, "502684")
        Me.ChkChequeL.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkChequeL.Size = New System.Drawing.Size(109, 16)
        Me.ChkChequeL.TabIndex = 13
        Me.ChkChequeL.Tag = "2747"
        Me.ChkChequeL.Text = "*Cheque Local"
        Me.ChkChequeL.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ChkChequeL, "")
        '
        'ChkEfectivo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.ChkEfectivo, False)
        Me.COBISViewResizer.SetAutoResize(Me.ChkEfectivo, False)
        Me.ChkEfectivo.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.ChkEfectivo, "Default")
        Me.ChkEfectivo.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkEfectivo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkEfectivo.ForeColor = System.Drawing.Color.Navy
        Me.ChkEfectivo.Location = New System.Drawing.Point(11, 22)
        Me.ChkEfectivo.Name = "ChkEfectivo"
        Me.COBISResourceProvider.SetResourceID(Me.ChkEfectivo, "508472")
        Me.ChkEfectivo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkEfectivo.Size = New System.Drawing.Size(109, 15)
        Me.ChkEfectivo.TabIndex = 11
        Me.ChkEfectivo.Text = "*Efectivo"
        Me.ChkEfectivo.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ChkEfectivo, "")
        '
        'ChkChequeP
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.ChkChequeP, False)
        Me.COBISViewResizer.SetAutoResize(Me.ChkChequeP, False)
        Me.ChkChequeP.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.ChkChequeP, "Default")
        Me.ChkChequeP.Cursor = System.Windows.Forms.Cursors.Default
        Me.ChkChequeP.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ChkChequeP.ForeColor = System.Drawing.Color.Navy
        Me.ChkChequeP.Location = New System.Drawing.Point(11, 38)
        Me.ChkChequeP.Name = "ChkChequeP"
        Me.COBISResourceProvider.SetResourceID(Me.ChkChequeP, "502685")
        Me.ChkChequeP.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ChkChequeP.Size = New System.Drawing.Size(109, 16)
        Me.ChkChequeP.TabIndex = 12
        Me.ChkChequeP.Tag = "2707"
        Me.ChkChequeP.Text = "*Cheque Propio"
        Me.ChkChequeP.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ChkChequeP, "")
        '
        'Optndnc
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Optndnc, False)
        Me.COBISViewResizer.SetAutoResize(Me.Optndnc, False)
        Me.Optndnc.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Optndnc, "Default")
        Me.Optndnc.Cursor = System.Windows.Forms.Cursors.Default
        Me.Optndnc.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Optndnc.ForeColor = System.Drawing.Color.Navy
        Me.Optndnc.Location = New System.Drawing.Point(11, 74)
        Me.Optndnc.Name = "Optndnc"
        Me.COBISResourceProvider.SetResourceID(Me.Optndnc, "502686")
        Me.Optndnc.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Optndnc.Size = New System.Drawing.Size(109, 16)
        Me.Optndnc.TabIndex = 14
        Me.Optndnc.Tag = "2747"
        Me.Optndnc.Text = "*Nota Débito"
        Me.Optndnc.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Optndnc, "")
        '
        'lblDescripcion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDescripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDescripcion, False)
        Me.lblDescripcion.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDescripcion.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDescripcion, "Default")
        Me.lblDescripcion.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDescripcion.Location = New System.Drawing.Point(135, 45)
        Me.lblDescripcion.Name = "lblDescripcion"
        Me.lblDescripcion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDescripcion.Size = New System.Drawing.Size(231, 20)
        Me.lblDescripcion.TabIndex = 99
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDescripcion, "")
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(12, 18)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "5084")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(49, 14)
        Me._lblEtiqueta_0.TabIndex = 99
        Me._lblEtiqueta_0.Text = "*Tipo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
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
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(12, 48)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "502066")
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(55, 14)
        Me._lblEtiqueta_2.TabIndex = 99
        Me._lblEtiqueta_2.Text = "*Causal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me.Frame2)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox1.Controls.Add(Me.lblDescripcion)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(6, 3)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.Size = New System.Drawing.Size(383, 81)
        Me.UltraGroupBox1.TabIndex = 1
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 268)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "502727")
        Me.GroupBox1.Size = New System.Drawing.Size(545, 158)
        Me.GroupBox1.TabIndex = 27
        Me.GroupBox1.Text = "*Causales:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguientes, Me.TSBCrear, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(586, 25)
        Me.TSBotones.TabIndex = 99
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguientes
        '
        Me.TSBSiguientes.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguientes.Image = CType(resources.GetObject("TSBSiguientes.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguientes.Name = "TSBSiguientes"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguientes, "2001")
        Me.TSBSiguientes.Size = New System.Drawing.Size(86, 22)
        Me.TSBSiguientes.Text = "*&Siguientes"
        '
        'TSBCrear
        '
        Me.TSBCrear.ForeColor = System.Drawing.Color.Black
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "2030")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "2030")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.ForeColor = System.Drawing.Color.Black
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "2005")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "2005")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2006")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.AccessibleDescription = ""
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
        'Pforma
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Pforma, False)
        Me.COBISViewResizer.SetAutoResize(Me.Pforma, False)
        Me.Pforma.Controls.Add(Me.UltraGroupBox2)
        Me.Pforma.Controls.Add(Me.GroupBox1)
        Me.Pforma.Controls.Add(Me._cmdBoton_0)
        Me.Pforma.Controls.Add(Me._cmdBoton_6)
        Me.Pforma.Controls.Add(Me.grdInterfaz)
        Me.Pforma.Controls.Add(Me._cmdBoton_5)
        Me.Pforma.Controls.Add(Me._cmdBoton_2)
        Me.Pforma.Controls.Add(Me._cmdBoton_3)
        Me.Pforma.Controls.Add(Me._cmdBoton_4)
        Me.Pforma.Controls.Add(Me._cmdBoton_1)
        Me.COBISStyleProvider.SetControlStyle(Me.Pforma, "Default")
        Me.Pforma.Location = New System.Drawing.Point(10, 36)
        Me.Pforma.Name = "Pforma"
        Me.Pforma.Size = New System.Drawing.Size(565, 431)
        Me.Pforma.TabIndex = 99
        Me.Pforma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Pforma, "")
        '
        'UltraGroupBox2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.Controls.Add(Me.UltraGroupBox1)
        Me.UltraGroupBox2.Controls.Add(Me.FrmInterfaz)
        Me.UltraGroupBox2.Controls.Add(Me._Frame4_2)
        Me.UltraGroupBox2.Controls.Add(Me._Frame4_0)
        Me.UltraGroupBox2.Controls.Add(Me._Frame4_1)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 12)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.UltraGroupBox2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox2.Size = New System.Drawing.Size(545, 248)
        Me.UltraGroupBox2.TabIndex = 0
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'FTran2913Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.Pforma)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(30, 128)
        Me.Name = "FTran2913Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(586, 475)
        Me.Text = "Parametrización Causales Otros Ingresos/Egresos"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.FrmInterfaz, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FrmInterfaz.ResumeLayout(False)
        CType(Me.grdInterfaz, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._Frame4_2, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame4_2.ResumeLayout(False)
        CType(Me.UltraGroupBox4, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox4.ResumeLayout(False)
        Me.UltraGroupBox4.PerformLayout()
        CType(Me.UltraGroupBox3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox3.ResumeLayout(False)
        Me.UltraGroupBox3.PerformLayout()
        CType(Me._Frame4_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame4_0.ResumeLayout(False)
        Me._Frame4_0.PerformLayout()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame2.ResumeLayout(False)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._Frame4_1, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame4_1.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Pforma.ResumeLayout(False)
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCaucc()
        Me.txtCaucc(1) = _txtCaucc_1
        Me.txtCaucc(0) = _txtCaucc_0
    End Sub
    Sub InitializetxtCauaho()
        Me.txtCauaho(1) = _txtCauaho_1
        Me.txtCauaho(0) = _txtCauaho_0
    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
    End Sub
    Sub InitializeoptOper()
        Me.optOper(2) = _optOper_2
        Me.optOper(3) = _optOper_3
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        'Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(2) = _lblEtiqueta_2
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(6) = _cmdBoton_6
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(1) = _cmdBoton_1
    End Sub
    Sub InitializeLblcauho()
        Me.Lblcauho(1) = _Lblcauho_1
        Me.Lblcauho(0) = _Lblcauho_0
    End Sub
    Sub InitializeLblcaucc()
        Me.Lblcaucc(1) = _Lblcaucc_1
        Me.Lblcaucc(0) = _Lblcaucc_0
    End Sub
    Sub InitializeFrame4()
        Me.Frame4(2) = _Frame4_2
        Me.Frame4(0) = _Frame4_0
        Me.Frame4(1) = _Frame4_1
    End Sub
    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguientes As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents UltraGroupBox4 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents UltraGroupBox3 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class



Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Public Class FConcTrnClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        InitializepicVisto()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
        InitializeCmbContab()
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
    Public WithEvents grdConta As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents txtConcepto As System.Windows.Forms.TextBox
    Private WithEvents _CmbContab_1 As System.Windows.Forms.ComboBox
    Private WithEvents _CmbContab_0 As System.Windows.Forms.ComboBox
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Public WithEvents Frame1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _CmbContab_2 As System.Windows.Forms.ComboBox
    Public WithEvents txtCausal As System.Windows.Forms.TextBox
    Public WithEvents txtTImpuesto As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_7 As System.Windows.Forms.TextBox
    Private WithEvents _picVisto_0 As System.Windows.Forms.PictureBox
    Private WithEvents _picVisto_1 As System.Windows.Forms.PictureBox
    Public WithEvents grdTran As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_15 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_14 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_17 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_16 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Public WithEvents lblconta As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Public WithEvents lblTImpuesto As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Public CmbContab(2) As System.Windows.Forms.ComboBox
    Public Line1(1) As System.Windows.Forms.Label
    Public cmdBoton(17) As System.Windows.Forms.Button
    Public lblDescripcion(3) As System.Windows.Forms.Label
    Public lblEtiqueta(8) As System.Windows.Forms.Label
    Public picVisto(1) As System.Windows.Forms.PictureBox
    Public txtCampo(7) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FConcTrnClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.grdConta = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.txtConcepto = New System.Windows.Forms.TextBox()
        Me.Frame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._CmbContab_1 = New System.Windows.Forms.ComboBox()
        Me._CmbContab_0 = New System.Windows.Forms.ComboBox()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._CmbContab_2 = New System.Windows.Forms.ComboBox()
        Me.txtCausal = New System.Windows.Forms.TextBox()
        Me.txtTImpuesto = New System.Windows.Forms.TextBox()
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._txtCampo_7 = New System.Windows.Forms.TextBox()
        Me._picVisto_0 = New System.Windows.Forms.PictureBox()
        Me._picVisto_1 = New System.Windows.Forms.PictureBox()
        Me.grdTran = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_15 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_14 = New System.Windows.Forms.Button()
        Me._cmdBoton_17 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_16 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me.lblconta = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me.lblTImpuesto = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdConta, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdTran, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox1.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
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
        'grdConta
        '
        Me.grdConta._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdConta, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdConta, False)
        Me.grdConta.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdConta.Clip = ""
        Me.grdConta.Col = CType(1, Short)
        Me.grdConta.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdConta.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdConta.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdConta, "Default")
        Me.grdConta.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdConta, True)
        Me.grdConta.FixedCols = CType(1, Short)
        Me.grdConta.FixedRows = CType(1, Short)
        Me.grdConta.ForeColor = System.Drawing.Color.Black
        Me.grdConta.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdConta.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdConta.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdConta.HighLight = True
        Me.grdConta.Location = New System.Drawing.Point(602, 457)
        Me.grdConta.Name = "grdConta"
        Me.grdConta.Picture = Nothing
        Me.grdConta.Row = CType(1, Short)
        Me.grdConta.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdConta.Size = New System.Drawing.Size(41, 33)
        Me.grdConta.Sort = CType(2, Short)
        Me.grdConta.TabIndex = 23
        Me.grdConta.TopRow = CType(1, Short)
        Me.grdConta.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdConta, "")
        '
        'txtConcepto
        '
        Me.txtConcepto.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtConcepto, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtConcepto, False)
        Me.txtConcepto.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtConcepto, "Default")
        Me.txtConcepto.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtConcepto.Location = New System.Drawing.Point(131, 102)
        Me.txtConcepto.MaxLength = 4
        Me.txtConcepto.Name = "txtConcepto"
        Me.txtConcepto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtConcepto.Size = New System.Drawing.Size(46, 20)
        Me.txtConcepto.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtConcepto, "")
        '
        'Frame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1, False)
        Me.Frame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1.Controls.Add(Me._CmbContab_1)
        Me.Frame1.Controls.Add(Me._CmbContab_0)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_1)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_6)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1, "Default")
        Me.Frame1.ForeColor = System.Drawing.Color.Navy
        Me.Frame1.Location = New System.Drawing.Point(13, 129)
        Me.Frame1.Name = "Frame1"
        Me.COBISResourceProvider.SetResourceID(Me.Frame1, "503299")
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(542, 50)
        Me.Frame1.TabIndex = 6
        Me.Frame1.Text = "*Campo del calculo de Base del Impuesto"
        Me.Frame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1, "")
        '
        '_CmbContab_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._CmbContab_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._CmbContab_1, False)
        Me._CmbContab_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._CmbContab_1, "Default")
        Me._CmbContab_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmbContab_1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CmbContab_1.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CmbContab_1.Location = New System.Drawing.Point(329, 22)
        Me._CmbContab_1.Name = "_CmbContab_1"
        Me._CmbContab_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmbContab_1.Size = New System.Drawing.Size(136, 21)
        Me._CmbContab_1.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me._CmbContab_1, "")
        '
        '_CmbContab_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._CmbContab_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._CmbContab_0, False)
        Me._CmbContab_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._CmbContab_0, "Default")
        Me._CmbContab_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmbContab_0.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CmbContab_0.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CmbContab_0.Location = New System.Drawing.Point(99, 22)
        Me._CmbContab_0.Name = "_CmbContab_0"
        Me._CmbContab_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmbContab_0.Size = New System.Drawing.Size(136, 21)
        Me._CmbContab_0.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._CmbContab_0, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(264, 22)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "503301")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(65, 20)
        Me._lblEtiqueta_1.TabIndex = 30
        Me._lblEtiqueta_1.Text = " *Base 2:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(26, 22)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "503300")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(65, 20)
        Me._lblEtiqueta_6.TabIndex = 29
        Me._lblEtiqueta_6.Text = " *Base 1:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_CmbContab_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._CmbContab_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._CmbContab_2, False)
        Me._CmbContab_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._CmbContab_2, "Default")
        Me._CmbContab_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._CmbContab_2.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me._CmbContab_2.ForeColor = System.Drawing.SystemColors.WindowText
        Me._CmbContab_2.Location = New System.Drawing.Point(410, 102)
        Me._CmbContab_2.Name = "_CmbContab_2"
        Me._CmbContab_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._CmbContab_2.Size = New System.Drawing.Size(146, 21)
        Me._CmbContab_2.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._CmbContab_2, "")
        '
        'txtCausal
        '
        Me.txtCausal.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCausal, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCausal, False)
        Me.txtCausal.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCausal, "Default")
        Me.txtCausal.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCausal.Location = New System.Drawing.Point(131, 56)
        Me.txtCausal.MaxLength = 4
        Me.txtCausal.Name = "txtCausal"
        Me.txtCausal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCausal.Size = New System.Drawing.Size(46, 20)
        Me.txtCausal.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCausal, "")
        '
        'txtTImpuesto
        '
        Me.txtTImpuesto.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTImpuesto, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTImpuesto, False)
        Me.txtTImpuesto.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtTImpuesto, "Default")
        Me.txtTImpuesto.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTImpuesto.Location = New System.Drawing.Point(131, 79)
        Me.txtTImpuesto.MaxLength = 1
        Me.txtTImpuesto.Name = "txtTImpuesto"
        Me.txtTImpuesto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTImpuesto.Size = New System.Drawing.Size(46, 20)
        Me.txtTImpuesto.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTImpuesto, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(131, 33)
        Me._txtCampo_0.MaxLength = 4
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(46, 20)
        Me._txtCampo_0.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_txtCampo_7
        '
        Me._txtCampo_7.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_7, False)
        Me._txtCampo_7.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_7, "Default")
        Me._txtCampo_7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_7.Location = New System.Drawing.Point(131, 10)
        Me._txtCampo_7.MaxLength = 2
        Me._txtCampo_7.Name = "_txtCampo_7"
        Me._txtCampo_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_7.Size = New System.Drawing.Size(46, 20)
        Me._txtCampo_7.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_7, "")
        '
        '_picVisto_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_0, False)
        Me._picVisto_0.BackColor = System.Drawing.Color.Gray
        Me._picVisto_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_0, "Default")
        Me._picVisto_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_0.Image = CType(resources.GetObject("_picVisto_0.Image"), System.Drawing.Image)
        Me._picVisto_0.Location = New System.Drawing.Point(561, 468)
        Me._picVisto_0.Name = "_picVisto_0"
        Me._picVisto_0.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_0.TabIndex = 16
        Me._picVisto_0.TabStop = False
        Me._picVisto_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_0, "")
        '
        '_picVisto_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._picVisto_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._picVisto_1, False)
        Me._picVisto_1.BackColor = System.Drawing.Color.Silver
        Me._picVisto_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._picVisto_1, "Default")
        Me._picVisto_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._picVisto_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._picVisto_1.Location = New System.Drawing.Point(516, 486)
        Me._picVisto_1.Name = "_picVisto_1"
        Me._picVisto_1.Size = New System.Drawing.Size(13, 13)
        Me._picVisto_1.TabIndex = 15
        Me._picVisto_1.TabStop = False
        Me._picVisto_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._picVisto_1, "")
        '
        'grdTran
        '
        Me.grdTran._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdTran, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdTran, False)
        Me.grdTran.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdTran.Clip = ""
        Me.grdTran.Col = CType(1, Short)
        Me.grdTran.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdTran.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdTran.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdTran, "Default")
        Me.grdTran.CtlText = ""
        Me.grdTran.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdTran, True)
        Me.grdTran.FixedCols = CType(1, Short)
        Me.grdTran.FixedRows = CType(1, Short)
        Me.grdTran.ForeColor = System.Drawing.Color.Black
        Me.grdTran.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdTran.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdTran.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdTran.HighLight = True
        Me.grdTran.Location = New System.Drawing.Point(3, 0)
        Me.grdTran.Name = "grdTran"
        Me.grdTran.Picture = Nothing
        Me.grdTran.Row = CType(1, Short)
        Me.grdTran.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdTran.Size = New System.Drawing.Size(562, 201)
        Me.grdTran.Sort = CType(2, Short)
        Me.grdTran.TabIndex = 0
        Me.grdTran.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdTran, "")
        '
        '_cmdBoton_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_15, False)
        Me._cmdBoton_15.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_15, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_15, True)
        Me._cmdBoton_15.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_15, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_15, Nothing)
        Me._cmdBoton_15.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_15.Location = New System.Drawing.Point(-594, 1)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_15, System.Drawing.Color.Silver)
        Me._cmdBoton_15.Name = "_cmdBoton_15"
        Me._cmdBoton_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_15.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_15, 1)
        Me._cmdBoton_15.TabIndex = 4
        Me._cmdBoton_15.TabStop = False
        Me._cmdBoton_15.Text = "*&Buscar"
        Me._cmdBoton_15.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_15.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_15, "")
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
        Me._cmdBoton_1.Enabled = False
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-594, 205)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 7
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Tag = "2536"
        Me._cmdBoton_1.Text = "*&Eliminar"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_cmdBoton_14
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_14, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_14, False)
        Me._cmdBoton_14.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_14, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_14, True)
        Me._cmdBoton_14.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_14, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_14, Nothing)
        Me._cmdBoton_14.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_14.Location = New System.Drawing.Point(-594, 308)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_14, System.Drawing.Color.Silver)
        Me._cmdBoton_14.Name = "_cmdBoton_14"
        Me._cmdBoton_14.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_14.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_14, 1)
        Me._cmdBoton_14.TabIndex = 10
        Me._cmdBoton_14.TabStop = False
        Me._cmdBoton_14.Text = "*&Salir"
        Me._cmdBoton_14.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_14.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_14, "")
        '
        '_cmdBoton_17
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_17, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_17, False)
        Me._cmdBoton_17.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_17, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_17, True)
        Me._cmdBoton_17.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_17, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_17, Nothing)
        Me._cmdBoton_17.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_17.Location = New System.Drawing.Point(-594, 256)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_17, System.Drawing.Color.Silver)
        Me._cmdBoton_17.Name = "_cmdBoton_17"
        Me._cmdBoton_17.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_17.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_17, 1)
        Me._cmdBoton_17.TabIndex = 9
        Me._cmdBoton_17.TabStop = False
        Me._cmdBoton_17.Text = "*&Limpiar"
        Me._cmdBoton_17.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_17.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_17, "")
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-594, 154)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 6
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Tag = "8002"
        Me._cmdBoton_3.Text = "*&Actualizar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        '_cmdBoton_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_16, False)
        Me._cmdBoton_16.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_16, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_16, True)
        Me._cmdBoton_16.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_16, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_16, Nothing)
        Me._cmdBoton_16.Enabled = False
        Me._cmdBoton_16.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_16.Location = New System.Drawing.Point(-594, 52)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_16, System.Drawing.Color.Silver)
        Me._cmdBoton_16.Name = "_cmdBoton_16"
        Me._cmdBoton_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_16.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_16, 1)
        Me._cmdBoton_16.TabIndex = 5
        Me._cmdBoton_16.TabStop = False
        Me._cmdBoton_16.Text = "*Si&guiente"
        Me._cmdBoton_16.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_16.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_16, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-594, 103)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 8
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        'lblconta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblconta, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblconta, False)
        Me.lblconta.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblconta.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblconta, "Default")
        Me.lblconta.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblconta.Location = New System.Drawing.Point(529, 532)
        Me.lblconta.Name = "lblconta"
        Me.lblconta.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblconta.Size = New System.Drawing.Size(36, 20)
        Me.lblconta.TabIndex = 32
        Me.lblconta.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblconta, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(270, 102)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "502226")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(140, 20)
        Me._lblEtiqueta_7.TabIndex = 24
        Me._lblEtiqueta_7.Text = "*Campo a Contabilizar:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(180, 56)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(375, 20)
        Me._lblDescripcion_1.TabIndex = 22
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        'lblTImpuesto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblTImpuesto, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblTImpuesto, False)
        Me.lblTImpuesto.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblTImpuesto.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblTImpuesto, "Default")
        Me.lblTImpuesto.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTImpuesto.Location = New System.Drawing.Point(180, 79)
        Me.lblTImpuesto.Name = "lblTImpuesto"
        Me.lblTImpuesto.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTImpuesto.Size = New System.Drawing.Size(375, 20)
        Me.lblTImpuesto.TabIndex = 21
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblTImpuesto, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 33)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "502231")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(117, 20)
        Me._lblEtiqueta_0.TabIndex = 20
        Me._lblEtiqueta_0.Text = "*Cód. Transacción:"
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
        Me._lblDescripcion_0.Location = New System.Drawing.Point(180, 33)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(375, 20)
        Me._lblDescripcion_0.TabIndex = 19
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(180, 10)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(375, 20)
        Me._lblDescripcion_3.TabIndex = 18
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "5048")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(117, 20)
        Me._lblEtiqueta_8.TabIndex = 17
        Me._lblEtiqueta_8.Text = "*Producto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(10, 102)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "9913")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(117, 20)
        Me._lblEtiqueta_4.TabIndex = 14
        Me._lblEtiqueta_4.Text = "*Concepto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(10, 79)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "503298")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(117, 20)
        Me._lblEtiqueta_3.TabIndex = 13
        Me._lblEtiqueta_3.Text = "*Tipo de Impuesto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 56)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "502066")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(117, 20)
        Me._lblEtiqueta_2.TabIndex = 12
        Me._lblEtiqueta_2.Text = "*Causal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox1)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._picVisto_0)
        Me.PFormas.Controls.Add(Me.lblconta)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_15)
        Me.PFormas.Controls.Add(Me._cmdBoton_16)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me._cmdBoton_14)
        Me.PFormas.Controls.Add(Me._cmdBoton_17)
        Me.PFormas.Controls.Add(Me._picVisto_1)
        Me.PFormas.Controls.Add(Me.grdConta)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(588, 415)
        Me.PFormas.TabIndex = 33
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.UltraGroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.UltraGroupBox1, False)
        Me.UltraGroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox1.BorderStyle = Infragistics.Win.Misc.GroupBoxBorderStyle.None
        Me.UltraGroupBox1.Controls.Add(Me.Label3)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_8)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_7)
        Me.UltraGroupBox1.Controls.Add(Me.Frame1)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_1)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_7)
        Me.UltraGroupBox1.Controls.Add(Me.txtConcepto)
        Me.UltraGroupBox1.Controls.Add(Me.lblTImpuesto)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_4)
        Me.UltraGroupBox1.Controls.Add(Me._txtCampo_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.UltraGroupBox1.Controls.Add(Me.txtTImpuesto)
        Me.UltraGroupBox1.Controls.Add(Me._CmbContab_2)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_0)
        Me.UltraGroupBox1.Controls.Add(Me._lblDescripcion_3)
        Me.UltraGroupBox1.Controls.Add(Me.txtCausal)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox1, "Default")
        Me.UltraGroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.UltraGroupBox1.Name = "UltraGroupBox1"
        Me.UltraGroupBox1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.UltraGroupBox1.Size = New System.Drawing.Size(568, 190)
        Me.UltraGroupBox1.TabIndex = 0
        Me.UltraGroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.UltraGroupBox1, "")
        '
        'Label3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label3, False)
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label3, "Default")
        Me.Label3.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label3.Location = New System.Drawing.Point(180, 103)
        Me.Label3.Name = "Label3"
        Me.Label3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label3.Size = New System.Drawing.Size(84, 19)
        Me.Label3.TabIndex = 31
        Me.Label3.UseMnemonic = False
        Me.Label3.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label3, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdTran)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 205)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(568, 204)
        Me.GroupBox1.TabIndex = 33
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBTransmitir, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(608, 25)
        Me.TSBotones.TabIndex = 34
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
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2020")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "500119")
        Me.TSBSiguiente.Size = New System.Drawing.Size(66, 22)
        Me.TSBSiguiente.Text = "*Sig&tes."
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
        'TSBActualizar
        '
        Me.TSBActualizar.ForeColor = System.Drawing.Color.Black
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "2031")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "2031")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.Color.Black
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2023")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2050")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
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
        'FConcTrnClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(8, 116)
        Me.Name = "FConcTrnClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(608, 461)
        Me.Text = "*Concepto Contable por Transacción"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdConta, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        CType(Me._picVisto_0, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me._picVisto_1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdTran, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.UltraGroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox1.ResumeLayout(False)
        Me.UltraGroupBox1.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(7) = _txtCampo_7
    End Sub
    Sub InitializepicVisto()
        Me.picVisto(0) = _picVisto_0
        Me.picVisto(1) = _picVisto_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(3) = _lblDescripcion_3
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(15) = _cmdBoton_15
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(14) = _cmdBoton_14
        Me.cmdBoton(17) = _cmdBoton_17
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(16) = _cmdBoton_16
        Me.cmdBoton(0) = _cmdBoton_0
    End Sub
    Sub InitializeCmbContab()
        Me.CmbContab(1) = _CmbContab_1
        Me.CmbContab(0) = _CmbContab_0
        Me.CmbContab(2) = _CmbContab_2
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Public WithEvents UltraGroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents Label3 As System.Windows.Forms.Label
#End Region
End Class



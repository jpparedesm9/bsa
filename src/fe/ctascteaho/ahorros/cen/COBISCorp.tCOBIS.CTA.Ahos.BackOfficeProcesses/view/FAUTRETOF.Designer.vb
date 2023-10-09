Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FAUTRETOFClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        'This call is required by the Windows Form Designer.
        InitializeComponent()
        InitializeoptPago()
        InitializelblEtiqueta()
        InitializecmdBoton()
        InitializeFrame1()
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
    Private WithEvents _optPago_2 As System.Windows.Forms.RadioButton
    Private WithEvents _optPago_3 As System.Windows.Forms.RadioButton
    Private WithEvents _Frame1_1 As Infragistics.Win.Misc.UltraGroupBox
    ' Public WithEvents txtValor As COBISCorp.Framework.UI.Components.CobisRealInput
    Private WithEvents _optPago_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optPago_1 As System.Windows.Forms.RadioButton
    Private WithEvents _Frame1_0 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents lblNombre As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public WithEvents fraTasas As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents grdAutoriza As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public Frame1(1) As Infragistics.Win.Misc.UltraGroupBox
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public lblEtiqueta(2) As System.Windows.Forms.Label
    Public optPago(3) As System.Windows.Forms.RadioButton
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FAUTRETOFClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.fraTasas = New Infragistics.Win.Misc.UltraGroupBox()
        Me._Frame1_1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optPago_2 = New System.Windows.Forms.RadioButton()
        Me._optPago_3 = New System.Windows.Forms.RadioButton()
        Me._Frame1_0 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optPago_0 = New System.Windows.Forms.RadioButton()
        Me._optPago_1 = New System.Windows.Forms.RadioButton()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.lblNombre = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.grdAutoriza = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBBloquear = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.txtValor = New COBISCorp.Framework.UI.Components.CobisRealInput()
        CType(Me.fraTasas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraTasas.SuspendLayout()
        CType(Me._Frame1_1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame1_1.SuspendLayout()
        CType(Me._Frame1_0, System.ComponentModel.ISupportInitialize).BeginInit()
        Me._Frame1_0.SuspendLayout()
        CType(Me.grdAutoriza, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
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
        'fraTasas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraTasas, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraTasas, False)
        Me.fraTasas.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraTasas.Controls.Add(Me.txtValor)
        Me.fraTasas.Controls.Add(Me._Frame1_1)
        Me.fraTasas.Controls.Add(Me._Frame1_0)
        Me.fraTasas.Controls.Add(Me.mskCuenta)
        Me.fraTasas.Controls.Add(Me.lblNombre)
        Me.fraTasas.Controls.Add(Me._lblEtiqueta_2)
        Me.fraTasas.Controls.Add(Me._lblEtiqueta_1)
        Me.fraTasas.Controls.Add(Me._lblEtiqueta_0)
        Me.COBISStyleProvider.SetControlStyle(Me.fraTasas, "Default")
        Me.fraTasas.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.fraTasas.ForeColor = System.Drawing.Color.Navy
        Me.fraTasas.Location = New System.Drawing.Point(10, 10)
        Me.fraTasas.Name = "fraTasas"
        Me.COBISResourceProvider.SetResourceID(Me.fraTasas, "5089")
        Me.fraTasas.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraTasas.Size = New System.Drawing.Size(577, 133)
        Me.fraTasas.TabIndex = 0
        Me.fraTasas.Text = "*Criterios de Búsqueda"
        Me.fraTasas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraTasas, "")
        '
        '_Frame1_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame1_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame1_1, False)
        Me._Frame1_1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame1_1.Controls.Add(Me._optPago_2)
        Me._Frame1_1.Controls.Add(Me._optPago_3)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame1_1, "Default")
        Me._Frame1_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame1_1.ForeColor = System.Drawing.Color.Navy
        Me._Frame1_1.Location = New System.Drawing.Point(307, 11)
        Me._Frame1_1.Name = "_Frame1_1"
        Me.COBISResourceProvider.SetResourceID(Me._Frame1_1, "508682")
        Me._Frame1_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame1_1.Size = New System.Drawing.Size(161, 37)
        Me._Frame1_1.TabIndex = 17
        Me._Frame1_1.Text = "*Oficina Radicadora"
        Me._Frame1_1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame1_1, "")
        '
        '_optPago_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optPago_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optPago_2, False)
        Me._optPago_2.AutoSize = True
        Me._optPago_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optPago_2, "Default")
        Me._optPago_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optPago_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optPago_2.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optPago_2.Location = New System.Drawing.Point(26, 16)
        Me._optPago_2.Name = "_optPago_2"
        Me.COBISResourceProvider.SetResourceID(Me._optPago_2, "5118")
        Me._optPago_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optPago_2.Size = New System.Drawing.Size(41, 17)
        Me._optPago_2.TabIndex = 18
        Me._optPago_2.TabStop = True
        Me._optPago_2.Text = "*Si"
        Me._optPago_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optPago_2, "")
        '
        '_optPago_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optPago_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optPago_3, False)
        Me._optPago_3.AutoSize = True
        Me._optPago_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optPago_3, "Default")
        Me._optPago_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optPago_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optPago_3.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optPago_3.Location = New System.Drawing.Point(82, 16)
        Me._optPago_3.Name = "_optPago_3"
        Me.COBISResourceProvider.SetResourceID(Me._optPago_3, "5119")
        Me._optPago_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optPago_3.Size = New System.Drawing.Size(46, 17)
        Me._optPago_3.TabIndex = 19
        Me._optPago_3.TabStop = True
        Me._optPago_3.Text = "*No"
        Me._optPago_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optPago_3, "")
        '
        '_Frame1_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._Frame1_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._Frame1_0, False)
        Me._Frame1_0.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._Frame1_0.Controls.Add(Me._optPago_0)
        Me._Frame1_0.Controls.Add(Me._optPago_1)
        Me.COBISStyleProvider.SetControlStyle(Me._Frame1_0, "Default")
        Me._Frame1_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._Frame1_0.ForeColor = System.Drawing.Color.Navy
        Me._Frame1_0.Location = New System.Drawing.Point(10, 76)
        Me._Frame1_0.Name = "_Frame1_0"
        Me.COBISResourceProvider.SetResourceID(Me._Frame1_0, "508589")
        Me._Frame1_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._Frame1_0.Size = New System.Drawing.Size(201, 45)
        Me._Frame1_0.TabIndex = 12
        Me._Frame1_0.Text = "*Forma Pago"
        Me._Frame1_0.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me._Frame1_0, "")
        '
        '_optPago_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optPago_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optPago_0, False)
        Me._optPago_0.AutoSize = True
        Me._optPago_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optPago_0, "Default")
        Me._optPago_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optPago_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optPago_0.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optPago_0.Location = New System.Drawing.Point(10, 20)
        Me._optPago_0.Name = "_optPago_0"
        Me.COBISResourceProvider.SetResourceID(Me._optPago_0, "2215")
        Me._optPago_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optPago_0.Size = New System.Drawing.Size(77, 17)
        Me._optPago_0.TabIndex = 13
        Me._optPago_0.TabStop = True
        Me._optPago_0.Text = "*Efectivo"
        Me._optPago_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optPago_0, "")
        '
        '_optPago_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optPago_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optPago_1, False)
        Me._optPago_1.AutoSize = True
        Me._optPago_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optPago_1, "Default")
        Me._optPago_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optPago_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._optPago_1.ForeColor = System.Drawing.Color.FromArgb(CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(128, Byte), Integer))
        Me._optPago_1.Location = New System.Drawing.Point(110, 20)
        Me._optPago_1.Name = "_optPago_1"
        Me.COBISResourceProvider.SetResourceID(Me._optPago_1, "501183")
        Me._optPago_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optPago_1.Size = New System.Drawing.Size(73, 17)
        Me._optPago_1.TabIndex = 14
        Me._optPago_1.TabStop = True
        Me._optPago_1.Text = "*Cheque"
        Me._optPago_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optPago_1, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(108, 28)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(131, 20)
        Me.mskCuenta.TabIndex = 9
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        'lblNombre
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNombre, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNombre, False)
        Me.lblNombre.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblNombre.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblNombre, "Default")
        Me.lblNombre.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNombre.Location = New System.Drawing.Point(108, 51)
        Me.lblNombre.Name = "lblNombre"
        Me.lblNombre.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNombre.Size = New System.Drawing.Size(456, 20)
        Me.lblNombre.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNombre, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.AutoSize = True
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(232, 74)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "5054")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(45, 13)
        Me._lblEtiqueta_2.TabIndex = 11
        Me._lblEtiqueta_2.Text = "*Valor:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.AutoSize = True
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 51)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "2438")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(103, 13)
        Me._lblEtiqueta_1.TabIndex = 8
        Me._lblEtiqueta_1.Text = "*Nombre Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.AutoSize = True
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 28)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "502287")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(80, 13)
        Me._lblEtiqueta_0.TabIndex = 7
        Me._lblEtiqueta_0.Text = "*No. Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'grdAutoriza
        '
        Me.grdAutoriza._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdAutoriza, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdAutoriza, False)
        Me.grdAutoriza.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdAutoriza.Clip = ""
        Me.grdAutoriza.Col = CType(1, Short)
        Me.grdAutoriza.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdAutoriza.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdAutoriza.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdAutoriza, "Default")
        Me.grdAutoriza.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdAutoriza, True)
        Me.grdAutoriza.FixedCols = CType(1, Short)
        Me.grdAutoriza.FixedRows = CType(1, Short)
        Me.grdAutoriza.ForeColor = System.Drawing.Color.Black
        Me.grdAutoriza.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdAutoriza.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdAutoriza.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdAutoriza.HighLight = True
        Me.grdAutoriza.Location = New System.Drawing.Point(10, 19)
        Me.grdAutoriza.Name = "grdAutoriza"
        Me.grdAutoriza.Picture = Nothing
        Me.grdAutoriza.Row = CType(1, Short)
        Me.grdAutoriza.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdAutoriza.Size = New System.Drawing.Size(554, 193)
        Me.grdAutoriza.Sort = CType(2, Short)
        Me.grdAutoriza.TabIndex = 1
        Me.grdAutoriza.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdAutoriza, "")
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
        Me._cmdBoton_0.Location = New System.Drawing.Point(-761, 46)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 2
        Me._cmdBoton_0.Text = "&Buscar"
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
        Me._cmdBoton_1.Location = New System.Drawing.Point(-761, 101)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 3
        Me._cmdBoton_1.Text = "&Transmitir"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(-761, 335)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 5
        Me._cmdBoton_4.Text = "&Salir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me._cmdBoton_2.Location = New System.Drawing.Point(-761, 277)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 6
        Me._cmdBoton_2.Text = "&Limpiar"
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
        Me._cmdBoton_3.Location = New System.Drawing.Point(-761, 164)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 57)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 16
        Me._cmdBoton_3.Tag = "2536"
        Me._cmdBoton_3.Text = "Bl&oquear"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me.fraTasas)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(598, 392)
        Me.PFormas.TabIndex = 18
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdAutoriza)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 149)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "508516")
        Me.GroupBox1.Size = New System.Drawing.Size(577, 228)
        Me.GroupBox1.TabIndex = 11
        Me.GroupBox1.Text = "*Datos:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBuscar, Me.TSBTransmitir, Me.TSBBloquear, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(621, 25)
        Me.TSBotones.TabIndex = 19
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBuscar
        '
        Me.TSBuscar.ForeColor = System.Drawing.Color.Navy
        Me.TSBuscar.Image = CType(resources.GetObject("TSBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBuscar, "2000")
        Me.TSBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBuscar.Name = "TSBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBuscar, "2000")
        Me.TSBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBuscar.Text = "*&Buscar"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Navy
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBBloquear
        '
        Me.TSBBloquear.ForeColor = System.Drawing.Color.Navy
        Me.TSBBloquear.Image = CType(resources.GetObject("TSBBloquear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBloquear, "2026")
        Me.TSBBloquear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBloquear.Name = "TSBBloquear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBloquear, "2501")
        Me.TSBBloquear.Size = New System.Drawing.Size(79, 22)
        Me.TSBBloquear.Text = "*Bl&oquear"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Navy
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
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'txtValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtValor, False)
        Me.txtValor.BackColor = System.Drawing.SystemColors.Window
        Me.txtValor.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtValor, "Default")
        Me.txtValor.DecimalPlaces = 2
        Me.txtValor.Location = New System.Drawing.Point(280, 72)
        Me.txtValor.MaxLength = 15
        Me.txtValor.MaxReal = 3.4E+38!
        Me.txtValor.MinReal = 0.0!
        Me.txtValor.Name = "txtValor"
        Me.txtValor.Separator = True
        Me.txtValor.Size = New System.Drawing.Size(148, 20)
        Me.txtValor.TabIndex = 101
        Me.txtValor.Text = "0.00"
        Me.txtValor.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.txtValor.ValueDouble = 0.0R
        Me.txtValor.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtValor, "")
        '
        'FAUTRETOFClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.Silver
        Me.Location = New System.Drawing.Point(144, 181)
        Me.Name = "FAUTRETOFClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(621, 437)
        Me.Text = "Autorización  Retiros en Oficina"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.fraTasas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraTasas.ResumeLayout(False)
        Me.fraTasas.PerformLayout()
        CType(Me._Frame1_1, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame1_1.ResumeLayout(False)
        Me._Frame1_1.PerformLayout()
        CType(Me._Frame1_0, System.ComponentModel.ISupportInitialize).EndInit()
        Me._Frame1_0.ResumeLayout(False)
        Me._Frame1_0.PerformLayout()
        CType(Me.grdAutoriza, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptPago()
        Me.optPago(2) = _optPago_2
        Me.optPago(3) = _optPago_3
        Me.optPago(0) = _optPago_0
        Me.optPago(1) = _optPago_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
    End Sub
    Sub InitializeFrame1()
        Me.Frame1(1) = _Frame1_1
        Me.Frame1(0) = _Frame1_0
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBloquear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Private WithEvents txtValor As COBISCorp.Framework.UI.Components.CobisRealInput
#End Region
End Class



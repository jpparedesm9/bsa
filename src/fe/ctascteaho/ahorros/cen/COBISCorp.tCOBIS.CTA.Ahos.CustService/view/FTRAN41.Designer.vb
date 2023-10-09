<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FTRAN41Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    'UserControl overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTRAN41Class))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.PForma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.chkOrigenRemesa = New System.Windows.Forms.CheckBox()
        Me.frmOrigenEfectivo = New Infragistics.Win.Misc.UltraGroupBox()
        Me._optOrigen_0 = New System.Windows.Forms.RadioButton()
        Me._optOrigen_1 = New System.Windows.Forms.RadioButton()
        Me.txtTotal = New System.Windows.Forms.TextBox()
        Me.lblTotal = New System.Windows.Forms.Label()
        Me.mskCheRemesas = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.mskChePropios = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.mskCheLocales = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.mskEfectivo = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.lblCheRemesas = New System.Windows.Forms.Label()
        Me.lblChePropios = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.txtMonDescripcion = New System.Windows.Forms.TextBox()
        Me.txtMonCodigo = New System.Windows.Forms.TextBox()
        Me.txtNombre = New System.Windows.Forms.TextBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.TSBotones.SuspendLayout()
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PForma.SuspendLayout()
        CType(Me.frmOrigenEfectivo, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.frmOrigenEfectivo.SuspendLayout()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.EnabledResize = True
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(664, 25)
        Me.TSBotones.TabIndex = 0
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.SystemColors.ControlText
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
        Me.TSBLimpiar.ForeColor = System.Drawing.SystemColors.ControlText
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
        Me.TSBSalir.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'PForma
        '
        Me.PForma.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.PForma, False)
        Me.COBISViewResizer.SetAutoResize(Me.PForma, False)
        Me.PForma.BackColorInternal = System.Drawing.Color.White
        Me.PForma.Controls.Add(Me.chkOrigenRemesa)
        Me.PForma.Controls.Add(Me.frmOrigenEfectivo)
        Me.PForma.Controls.Add(Me.txtTotal)
        Me.PForma.Controls.Add(Me.lblTotal)
        Me.PForma.Controls.Add(Me.mskCheRemesas)
        Me.PForma.Controls.Add(Me.mskChePropios)
        Me.PForma.Controls.Add(Me.mskCheLocales)
        Me.PForma.Controls.Add(Me.mskEfectivo)
        Me.PForma.Controls.Add(Me.lblCheRemesas)
        Me.PForma.Controls.Add(Me.lblChePropios)
        Me.PForma.Controls.Add(Me.Label3)
        Me.PForma.Controls.Add(Me.Label2)
        Me.PForma.Controls.Add(Me.Label1)
        Me.PForma.Controls.Add(Me.txtMonDescripcion)
        Me.PForma.Controls.Add(Me.txtMonCodigo)
        Me.PForma.Controls.Add(Me.txtNombre)
        Me.PForma.Controls.Add(Me.mskCuenta)
        Me.PForma.Controls.Add(Me._lblEtiqueta_0)
        Me.PForma.Controls.Add(Me._lblEtiqueta_6)
        Me.COBISStyleProvider.SetControlStyle(Me.PForma, "Default")
        Me.PForma.Location = New System.Drawing.Point(8, 33)
        Me.PForma.Name = "PForma"
        Me.PForma.Size = New System.Drawing.Size(642, 227)
        Me.PForma.TabIndex = 1
        Me.PForma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PForma, "")
        '
        'chkOrigenRemesa
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkOrigenRemesa, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkOrigenRemesa, False)
        Me.chkOrigenRemesa.AutoSize = True
        Me.chkOrigenRemesa.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkOrigenRemesa, "Default")
        Me.chkOrigenRemesa.ForeColor = System.Drawing.Color.Navy
        Me.chkOrigenRemesa.Location = New System.Drawing.Point(364, 94)
        Me.chkOrigenRemesa.Name = "chkOrigenRemesa"
        Me.chkOrigenRemesa.Size = New System.Drawing.Size(15, 14)
        Me.chkOrigenRemesa.TabIndex = 8
        Me.chkOrigenRemesa.UseVisualStyleBackColor = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkOrigenRemesa, "")
        '
        'frmOrigenEfectivo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.frmOrigenEfectivo, False)
        Me.COBISViewResizer.SetAutoResize(Me.frmOrigenEfectivo, False)
        Me.frmOrigenEfectivo.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.frmOrigenEfectivo.Controls.Add(Me._optOrigen_0)
        Me.frmOrigenEfectivo.Controls.Add(Me._optOrigen_1)
        Me.COBISStyleProvider.SetControlStyle(Me.frmOrigenEfectivo, "Default")
        Me.frmOrigenEfectivo.Enabled = False
        Me.frmOrigenEfectivo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.frmOrigenEfectivo.ForeColor = System.Drawing.Color.Navy
        Me.frmOrigenEfectivo.Location = New System.Drawing.Point(356, 92)
        Me.frmOrigenEfectivo.Name = "frmOrigenEfectivo"
        Me.COBISResourceProvider.SetResourceID(Me.frmOrigenEfectivo, "509557")
        Me.frmOrigenEfectivo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.frmOrigenEfectivo.Size = New System.Drawing.Size(240, 46)
        Me.frmOrigenEfectivo.TabIndex = 26
        Me.frmOrigenEfectivo.Tag = ""
        Me.frmOrigenEfectivo.Text = "       *Si es remesa indique el origen:"
        Me.frmOrigenEfectivo.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.frmOrigenEfectivo, "")
        '
        '_optOrigen_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOrigen_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOrigen_0, False)
        Me._optOrigen_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOrigen_0, "Default")
        Me._optOrigen_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOrigen_0.ForeColor = System.Drawing.Color.Navy
        Me._optOrigen_0.Location = New System.Drawing.Point(28, 20)
        Me._optOrigen_0.Name = "_optOrigen_0"
        Me.COBISResourceProvider.SetResourceID(Me._optOrigen_0, "509555")
        Me._optOrigen_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOrigen_0.Size = New System.Drawing.Size(70, 18)
        Me._optOrigen_0.TabIndex = 9
        Me._optOrigen_0.TabStop = True
        Me._optOrigen_0.Text = "*Local"
        Me._optOrigen_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOrigen_0, "")
        '
        '_optOrigen_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optOrigen_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optOrigen_1, False)
        Me._optOrigen_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optOrigen_1, "Default")
        Me._optOrigen_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optOrigen_1.ForeColor = System.Drawing.Color.Navy
        Me._optOrigen_1.Location = New System.Drawing.Point(106, 20)
        Me._optOrigen_1.Name = "_optOrigen_1"
        Me.COBISResourceProvider.SetResourceID(Me._optOrigen_1, "509556")
        Me._optOrigen_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optOrigen_1.Size = New System.Drawing.Size(66, 18)
        Me._optOrigen_1.TabIndex = 10
        Me._optOrigen_1.Text = "*Exterior"
        Me._optOrigen_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optOrigen_1, "")
        '
        'txtTotal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTotal, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTotal, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtTotal, "Default")
        Me.txtTotal.Location = New System.Drawing.Point(168, 196)
        Me.txtTotal.Name = "txtTotal"
        Me.txtTotal.ReadOnly = True
        Me.txtTotal.Size = New System.Drawing.Size(147, 20)
        Me.txtTotal.TabIndex = 13
        Me.txtTotal.TabStop = False
        Me.txtTotal.Text = "0.00"
        Me.txtTotal.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTotal, "")
        '
        'lblTotal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblTotal, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblTotal, False)
        Me.lblTotal.AutoSize = True
        Me.lblTotal.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblTotal, "Default")
        Me.lblTotal.ForeColor = System.Drawing.Color.Navy
        Me.lblTotal.Location = New System.Drawing.Point(11, 199)
        Me.lblTotal.Name = "lblTotal"
        Me.COBISResourceProvider.SetResourceID(Me.lblTotal, "500040")
        Me.lblTotal.Size = New System.Drawing.Size(38, 13)
        Me.lblTotal.TabIndex = 25
        Me.lblTotal.Text = "*Total:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblTotal, "")
        '
        'mskCheRemesas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCheRemesas, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCheRemesas, False)
        Me.mskCheRemesas.BackColor = System.Drawing.SystemColors.Window
        Me.mskCheRemesas.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskCheRemesas.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskCheRemesas, "Default")
        Me.mskCheRemesas.Cuantas = 0
        Me.mskCheRemesas.DateString = "_.$"
        Me.mskCheRemesas.DateSybase = Nothing
        Me.mskCheRemesas.Decimals = CType(2, Short)
        Me.mskCheRemesas.Errores = CType(0, Short)
        Me.mskCheRemesas.Fin = 0
        Me.mskCheRemesas.FormattedText = Nothing
        Me.mskCheRemesas.HelpLine = Nothing
        Me.mskCheRemesas.hWnd = 0
        Me.mskCheRemesas.Location = New System.Drawing.Point(168, 170)
        Me.mskCheRemesas.Mask = " "
        Me.mskCheRemesas.MaxReal = 1.0E+15!
        Me.mskCheRemesas.MinReal = 0.0!
        Me.mskCheRemesas.Name = "mskCheRemesas"
        Me.mskCheRemesas.Nullable = False
        Me.mskCheRemesas.Separator = True
        Me.mskCheRemesas.Size = New System.Drawing.Size(147, 20)
        Me.mskCheRemesas.StringIndex = CType(0, Short)
        Me.mskCheRemesas.TabIndex = 7
        Me.mskCheRemesas.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.mskCheRemesas.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCheRemesas, "")
        '
        'mskChePropios
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskChePropios, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskChePropios, False)
        Me.mskChePropios.BackColor = System.Drawing.SystemColors.Window
        Me.mskChePropios.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskChePropios.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskChePropios, "Default")
        Me.mskChePropios.Cuantas = 0
        Me.mskChePropios.DateString = "_.$"
        Me.mskChePropios.DateSybase = Nothing
        Me.mskChePropios.Decimals = CType(2, Short)
        Me.mskChePropios.Errores = CType(0, Short)
        Me.mskChePropios.Fin = 0
        Me.mskChePropios.FormattedText = Nothing
        Me.mskChePropios.HelpLine = Nothing
        Me.mskChePropios.hWnd = 0
        Me.mskChePropios.Location = New System.Drawing.Point(168, 144)
        Me.mskChePropios.Mask = " "
        Me.mskChePropios.MaxReal = 1.0E+15!
        Me.mskChePropios.MinReal = 0.0!
        Me.mskChePropios.Name = "mskChePropios"
        Me.mskChePropios.Nullable = False
        Me.mskChePropios.Separator = True
        Me.mskChePropios.Size = New System.Drawing.Size(147, 20)
        Me.mskChePropios.StringIndex = CType(0, Short)
        Me.mskChePropios.TabIndex = 6
        Me.mskChePropios.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.mskChePropios.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskChePropios, "")
        '
        'mskCheLocales
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCheLocales, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCheLocales, False)
        Me.mskCheLocales.BackColor = System.Drawing.SystemColors.Window
        Me.mskCheLocales.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskCheLocales.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskCheLocales, "Default")
        Me.mskCheLocales.Cuantas = 0
        Me.mskCheLocales.DateString = "_.$"
        Me.mskCheLocales.DateSybase = Nothing
        Me.mskCheLocales.Decimals = CType(2, Short)
        Me.mskCheLocales.Errores = CType(0, Short)
        Me.mskCheLocales.Fin = 0
        Me.mskCheLocales.FormattedText = Nothing
        Me.mskCheLocales.HelpLine = Nothing
        Me.mskCheLocales.hWnd = 0
        Me.mskCheLocales.Location = New System.Drawing.Point(168, 118)
        Me.mskCheLocales.Mask = " "
        Me.mskCheLocales.MaxReal = 1.0E+15!
        Me.mskCheLocales.MinReal = 0.0!
        Me.mskCheLocales.Name = "mskCheLocales"
        Me.mskCheLocales.Nullable = False
        Me.mskCheLocales.Separator = True
        Me.mskCheLocales.Size = New System.Drawing.Size(147, 20)
        Me.mskCheLocales.StringIndex = CType(0, Short)
        Me.mskCheLocales.TabIndex = 5
        Me.mskCheLocales.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCheLocales, "")
        '
        'mskEfectivo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskEfectivo, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskEfectivo, False)
        Me.mskEfectivo.BackColor = System.Drawing.SystemColors.Window
        Me.mskEfectivo.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskEfectivo.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskEfectivo, "Default")
        Me.mskEfectivo.Cuantas = 0
        Me.mskEfectivo.DateString = "_.$"
        Me.mskEfectivo.DateSybase = Nothing
        Me.mskEfectivo.Decimals = CType(2, Short)
        Me.mskEfectivo.Errores = CType(0, Short)
        Me.mskEfectivo.Fin = 0
        Me.mskEfectivo.FormattedText = Nothing
        Me.mskEfectivo.HelpLine = Nothing
        Me.mskEfectivo.hWnd = 0
        Me.mskEfectivo.Location = New System.Drawing.Point(168, 92)
        Me.mskEfectivo.Mask = " "
        Me.mskEfectivo.MaxReal = 1.0E+15!
        Me.mskEfectivo.MinReal = 0.0!
        Me.mskEfectivo.Name = "mskEfectivo"
        Me.mskEfectivo.Nullable = False
        Me.mskEfectivo.Separator = True
        Me.mskEfectivo.Size = New System.Drawing.Size(147, 20)
        Me.mskEfectivo.StringIndex = CType(0, Short)
        Me.mskEfectivo.TabIndex = 4
        Me.mskEfectivo.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskEfectivo, "")
        '
        'lblCheRemesas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCheRemesas, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCheRemesas, False)
        Me.lblCheRemesas.AutoSize = True
        Me.lblCheRemesas.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblCheRemesas, "Default")
        Me.lblCheRemesas.ForeColor = System.Drawing.Color.Navy
        Me.lblCheRemesas.Location = New System.Drawing.Point(11, 173)
        Me.lblCheRemesas.Name = "lblCheRemesas"
        Me.COBISResourceProvider.SetResourceID(Me.lblCheRemesas, "509506")
        Me.lblCheRemesas.Size = New System.Drawing.Size(101, 13)
        Me.lblCheRemesas.TabIndex = 20
        Me.lblCheRemesas.Text = "*Cheques remesas :"
        Me.lblCheRemesas.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCheRemesas, "")
        '
        'lblChePropios
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblChePropios, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblChePropios, False)
        Me.lblChePropios.AutoSize = True
        Me.lblChePropios.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblChePropios, "Default")
        Me.lblChePropios.ForeColor = System.Drawing.Color.Navy
        Me.lblChePropios.Location = New System.Drawing.Point(11, 147)
        Me.lblChePropios.Name = "lblChePropios"
        Me.COBISResourceProvider.SetResourceID(Me.lblChePropios, "501346")
        Me.lblChePropios.Size = New System.Drawing.Size(96, 13)
        Me.lblChePropios.TabIndex = 19
        Me.lblChePropios.Text = "*Cheques propios :"
        Me.lblChePropios.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblChePropios, "")
        '
        'Label3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label3, False)
        Me.Label3.AutoSize = True
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label3, "Default")
        Me.Label3.ForeColor = System.Drawing.Color.Navy
        Me.Label3.Location = New System.Drawing.Point(11, 121)
        Me.Label3.Name = "Label3"
        Me.COBISResourceProvider.SetResourceID(Me.Label3, "509505")
        Me.Label3.Size = New System.Drawing.Size(95, 13)
        Me.Label3.TabIndex = 18
        Me.Label3.Text = "*Cheques locales :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label3, "")
        '
        'Label2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label2, False)
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label2, "Default")
        Me.Label2.ForeColor = System.Drawing.Color.Navy
        Me.Label2.Location = New System.Drawing.Point(11, 95)
        Me.Label2.Name = "Label2"
        Me.COBISResourceProvider.SetResourceID(Me.Label2, "501348")
        Me.Label2.Size = New System.Drawing.Size(56, 13)
        Me.Label2.TabIndex = 17
        Me.Label2.Text = "*Efectivo :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label2, "")
        '
        'Label1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label1, False)
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.ForeColor = System.Drawing.Color.Navy
        Me.Label1.Location = New System.Drawing.Point(11, 69)
        Me.Label1.Name = "Label1"
        Me.COBISResourceProvider.SetResourceID(Me.Label1, "5209")
        Me.Label1.Size = New System.Drawing.Size(56, 13)
        Me.Label1.TabIndex = 14
        Me.Label1.Text = "*Moneda :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label1, "")
        '
        'txtMonDescripcion
        '
        Me.txtMonDescripcion.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtMonDescripcion, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtMonDescripcion, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtMonDescripcion, "Default")
        Me.txtMonDescripcion.Location = New System.Drawing.Point(204, 66)
        Me.txtMonDescripcion.Name = "txtMonDescripcion"
        Me.txtMonDescripcion.ReadOnly = True
        Me.txtMonDescripcion.Size = New System.Drawing.Size(419, 20)
        Me.txtMonDescripcion.TabIndex = 3
        Me.txtMonDescripcion.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtMonDescripcion, "")
        '
        'txtMonCodigo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtMonCodigo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtMonCodigo, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtMonCodigo, "Default")
        Me.txtMonCodigo.Location = New System.Drawing.Point(168, 66)
        Me.txtMonCodigo.Name = "txtMonCodigo"
        Me.txtMonCodigo.ReadOnly = True
        Me.txtMonCodigo.Size = New System.Drawing.Size(30, 20)
        Me.txtMonCodigo.TabIndex = 2
        Me.txtMonCodigo.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtMonCodigo, "")
        '
        'txtNombre
        '
        Me.txtNombre.Anchor = CType(((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNombre, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNombre, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtNombre, "Default")
        Me.txtNombre.Location = New System.Drawing.Point(168, 40)
        Me.txtNombre.Name = "txtNombre"
        Me.txtNombre.ReadOnly = True
        Me.txtNombre.Size = New System.Drawing.Size(455, 20)
        Me.txtNombre.TabIndex = 1
        Me.txtNombre.TabStop = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNombre, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(168, 14)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(147, 20)
        Me.mskCuenta.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.AutoSize = True
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(11, 17)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501874")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(128, 13)
        Me._lblEtiqueta_0.TabIndex = 11
        Me._lblEtiqueta_0.Text = "*Num. de cuenta ahorros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.AutoSize = True
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(11, 43)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "500108")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(113, 13)
        Me._lblEtiqueta_6.TabIndex = 12
        Me._lblEtiqueta_6.Text = "*Nombre de la cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'FTRAN41Class
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.White
        Me.Controls.Add(Me.PForma)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Name = "FTRAN41Class"
        Me.Size = New System.Drawing.Size(664, 270)
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PForma.ResumeLayout(False)
        Me.PForma.PerformLayout()
        CType(Me.frmOrigenEfectivo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.frmOrigenEfectivo.ResumeLayout(False)
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents PForma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents txtMonDescripcion As System.Windows.Forms.TextBox
    Friend WithEvents txtMonCodigo As System.Windows.Forms.TextBox
    Friend WithEvents txtNombre As System.Windows.Forms.TextBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Friend WithEvents lblCheRemesas As System.Windows.Forms.Label
    Friend WithEvents lblChePropios As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents txtTotal As System.Windows.Forms.TextBox
    Friend WithEvents lblTotal As System.Windows.Forms.Label
    Friend WithEvents mskCheRemesas As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents mskChePropios As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents mskCheLocales As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents mskEfectivo As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents frmOrigenEfectivo As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _optOrigen_0 As System.Windows.Forms.RadioButton
    Private WithEvents _optOrigen_1 As System.Windows.Forms.RadioButton
    Friend WithEvents chkOrigenRemesa As System.Windows.Forms.CheckBox

End Class

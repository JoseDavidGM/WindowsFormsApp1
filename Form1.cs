using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Linq.Expressions;

namespace WindowsFormsApp1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        public static string user;
        public static string pass;
        public static string rol;
        //coneccion a la base de datos
        SqlConnection conn = new SqlConnection("server=JOSEDAVID ; database=App1 ; integrated security = true");

        //login es un metodo que ejecuta un procedimiento en la base de datos para realizar la conexión y desconexión de los usuarios.
        //dentro del procedimiento se valida usuario, contraseña y crea el registro de conexión en caso de ser exitosa.
        public void login (string opt, string user, string pass)
        {
            string message = string.Empty; 
            try
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("[SP_login_logout]", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("opt", opt);
                cmd.Parameters.AddWithValue("user", user);
                cmd.Parameters.AddWithValue("pass", pass);
                cmd.Parameters.Add("@rol", SqlDbType.NVarChar, 400);
                cmd.Parameters["@rol"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@mess", SqlDbType.NVarChar, 400);
                cmd.Parameters["@mess"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                message = (string)cmd.Parameters["@mess"].Value;
                
                if (message == "Connected")
                {
                    rol = (string)cmd.Parameters["@rol"].Value;
                    this.Hide();
                    Form2 frm2 = new Form2();
                    frm2.Show();
                }
                else
                {
                    MessageBox.Show(message, "...::: App1 :::...", MessageBoxButtons.OK,MessageBoxIcon.Warning);
                }
                conn.Close();
            }
            catch (Exception e){
                MessageBox.Show(e.Message);
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox1.Text.ToString() == "" | textBox2.Text.ToString() == "")
            {
                MessageBox.Show("User and password required", "...::: App1 :::...", MessageBoxButtons.OK,MessageBoxIcon.Warning);
            }
            else
            {
                user = textBox1.Text.ToString();
                pass = textBox2.Text.ToString();
                login("1",user,pass);
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}

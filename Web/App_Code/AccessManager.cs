using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.OleDb;
using System.Data;
using System.Configuration;

namespace DBManager
{
    public class AccessManager
    {
        private static object lockobj = new object();
        protected static OleDbConnection conn = new OleDbConnection();
        protected static OleDbCommand comm = new OleDbCommand();
        public AccessManager()
        {
            //init
        }

        /// <summary>
        /// 打开数据库
        /// </summary>
        private static void openConnection()
        {
            if (conn.State == ConnectionState.Closed)
            {
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;//web.config文件里设定。             
                comm.Connection = conn;
                try
                {
                    conn.Open();
                }
                catch (Exception e)
                { throw new Exception(e.Message); }

            }

        }

        /// <summary>
        /// 关闭数据库
        /// </summary>
        private static void closeConnection()
        {
            if (conn.State == ConnectionState.Open)
            {
                conn.Close();
                conn.Dispose();
                comm.Dispose();
            }
        }
        /// <summary>
        /// 执行插入后返回id
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <returns></returns>
        public static int InsertReturnID(string sqlstr)
        {
            lock (lockobj)
            {
                OleDbDataReader dr = null;
                int ID = 0;
                try
                {
                    openConnection();
                    comm.CommandText = sqlstr;
                    comm.CommandType = CommandType.Text;
                    comm.ExecuteNonQuery();

                    comm.CommandText = "select @@identity";
                    comm.CommandType = CommandType.Text;
                    dr = comm.ExecuteReader(CommandBehavior.CloseConnection);
                    while (dr.Read())
                    {
                        ID = (int)dr[0];
                    }
                }
                catch
                {

                }
                if (dr != null) dr.Close();
                closeConnection();
                return ID;
            }


        }

        /// <summary>
        /// 执行sql语句
        /// </summary>
        /// <param name="sqlstr"></param>
        public static string excuteSql(string sqlstr)
        {
            lock (lockobj)
            {
                string result = "error";
                try
                {

                    openConnection();
                    comm.CommandType = CommandType.Text;
                    comm.CommandText = sqlstr;
                    int cout = comm.ExecuteNonQuery();
                    if (cout > 0) result = "success";

                }
                catch (Exception e)
                {
                    result = "error" + e.Message;

                }
                closeConnection();
                return result;
            }


        }
        /// <summary>
        /// 返回影响数目
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <returns></returns>
        public static int excuteRowcount(string sqlstr)
        {
            lock (lockobj)
            {
                int count = 0;
                try
                {
                    openConnection();
                    comm.CommandType = CommandType.Text;
                    comm.CommandText = sqlstr;
                    count = int.Parse(comm.ExecuteScalar().ToString());

                }
                catch (Exception e)
                {
                    count = -1;

                }
                closeConnection();
                return count;
            }

        }


        /// <summary>
        /// 返回指定sql语句的OleDbDataReader对象，使用时请注意关闭这个对象。
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <returns></returns>
        public static OleDbDataReader dataReader(string sqlstr)
        {
            lock (lockobj)
            {
                OleDbDataReader dr = null;
                try
                {
                    openConnection();
                    comm.CommandText = sqlstr;
                    comm.CommandType = CommandType.Text;

                    dr = comm.ExecuteReader(CommandBehavior.CloseConnection);
                }
                catch
                {
                    try
                    {
                        dr.Close();
                        closeConnection();
                    }
                    catch { }
                }
                return dr;
            }

        }

        /// <summary>
        /// 返回指定sql语句的OleDbDataReader对象,使用时请注意关闭
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <param name="dr"></param>
        public static void dataReader(string sqlstr, ref OleDbDataReader dr)
        {
            lock (lockobj)
            {
                try
                {
                    openConnection();
                    comm.CommandText = sqlstr;
                    comm.CommandType = CommandType.Text;
                    dr = comm.ExecuteReader(CommandBehavior.CloseConnection);
                }
                catch
                {
                    try
                    {
                        if (dr != null && !dr.IsClosed)
                            dr.Close();
                    }
                    catch
                    {
                    }
                    finally
                    {
                        closeConnection();
                    }
                }
            }

        }

        /// <summary>
        /// 返回指定sql语句的dataset
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <returns></returns>
        public static DataSet dataSet(string sqlstr)
        {
            lock (lockobj)
            {
                DataSet ds = new DataSet();
                OleDbDataAdapter da = new OleDbDataAdapter();
                try
                {
                    openConnection();
                    comm.CommandType = CommandType.Text;
                    comm.CommandText = sqlstr;
                    da.SelectCommand = comm;
                    da.Fill(ds);

                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                finally
                {
                    closeConnection();
                }
                return ds;
            }

        }

        /// <summary>
        /// 返回指定sql语句的dataset
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <param name="ds"></param>
        public static void dataSet(string sqlstr, ref DataSet ds)
        {
            lock (lockobj)
            {
                OleDbDataAdapter da = new OleDbDataAdapter();
                try
                {
                    openConnection();
                    comm.CommandType = CommandType.Text;
                    comm.CommandText = sqlstr;
                    da.SelectCommand = comm;
                    da.Fill(ds);
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                finally
                {
                    closeConnection();
                }
            }

        }

        /// <summary>
        /// 返回指定sql语句的datatable
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <returns></returns>
        public static DataTable dataTable(string sqlstr)
        {
            lock (lockobj)
            {
                DataTable dt = new DataTable();
                OleDbDataAdapter da = new OleDbDataAdapter();
                try
                {
                    openConnection();
                    comm.CommandType = CommandType.Text;
                    comm.CommandText = sqlstr;
                    da.SelectCommand = comm;
                    da.Fill(dt);
                }
                catch (Exception e)
                {

                }
                finally
                {
                    closeConnection();
                }
                return dt;
            }

        }

        /// <summary>
        /// 返回指定sql语句的datatable
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <param name="dt"></param>
        public static void dataTable(string sqlstr, ref DataTable dt)
        {
            lock (lockobj)
            {
                OleDbDataAdapter da = new OleDbDataAdapter();
                try
                {
                    openConnection();
                    comm.CommandType = CommandType.Text;
                    comm.CommandText = sqlstr;
                    da.SelectCommand = comm;
                    da.Fill(dt);
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                finally
                {
                    closeConnection();
                }
            }

        }

        /// <summary>
        /// 返回指定sql语句的dataview
        /// </summary>
        /// <param name="sqlstr"></param>
        /// <returns></returns>
        public static DataView dataView(string sqlstr)
        {
            lock (lockobj)
            {
                OleDbDataAdapter da = new OleDbDataAdapter();
                DataView dv = new DataView();
                DataSet ds = new DataSet();
                try
                {
                    openConnection();
                    comm.CommandType = CommandType.Text;
                    comm.CommandText = sqlstr;
                    da.SelectCommand = comm;
                    da.Fill(ds);
                    dv = ds.Tables[0].DefaultView;
                }
                catch (Exception e)
                {
                    throw new Exception(e.Message);
                }
                finally
                {
                    closeConnection();
                }
                return dv;
            }

        }

        /// <summary>
        /// 重排序字段Sequence
        /// </summary>
        /// <param name="tableName"></param>
        public static string Reorder(string tableName, string field)
        {
            lock (lockobj)
            {
                string result = "";
                try
                {
                    string sqlall = "select ID from " + tableName + " order by " + field + " asc";

                    DataTable dataTable = DBManager.AccessManager.dataTable(sqlall);

                    for (int i = 0; i < dataTable.Rows.Count; i++)
                    {
                        int currId = int.Parse(dataTable.Rows[i][0].ToString());
                        string updataSql = "update " + tableName + " set [" + field + "]=" + (i + 1) + "  where ID=" + currId;

                        string ss = DBManager.AccessManager.excuteSql(updataSql);
                        if (ss.IndexOf("error") > -1)
                        {
                            result = ss;
                            break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    result = "error:" + ex.Message;
                }
                return result;
            }


        }
    }
}

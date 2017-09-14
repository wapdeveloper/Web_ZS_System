<%@ WebHandler Language="C#" Class="ResultsDirectoryHandler" %>

using System;
using System.Web;




public class ResultsDirectoryHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "text/plain";
        try
        {
            string result = string.Empty;
            string operation = context.Request["operation"].ToString();
            string condition = context.Request["condition"].ToString();

            switch (operation)
            {
                case "searchall":
                    result = SearchAll();
                    break;
                case "search":
                    {
                        result = Search(condition);
                    }
                    break;
            }
            context.Response.Write(result);

        }

        catch (Exception ex)
        {
            context.Response.Write("error:" + ex.Message.ToString());
        }
    }

    private string SearchAll()
    {
        string result = string.Empty;
        string sql = string.Empty;

        sql = "select ww,pp,type from [Table] order by type";

        System.Data.DataTable dt = DBManager.AccessManager.dataTable(sql);
        result = Serialize.SerializeByDataTable(dt, false);
        return result;
    }

    private string Search(string condition)
    {
        string result = string.Empty;
        string sql = string.Empty;

        sql = "select pp from [Table] where pp like '%"+condition+"%'";

        System.Data.DataTable dt = DBManager.AccessManager.dataTable(sql);
        result = Serialize.SerializeByDataTable(dt, false);
        return result;
    }
    private string SearchDec(string val)
    {
        string result = string.Empty;
        string sql = "select * from ResultDirInfo where [Type] like '" + val + "' order by Type";
        System.Data.DataTable dt = DBManager.AccessManager.dataTable(sql);
        result = Serialize.SerializeByDataTable(dt, false);
        return result;
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;

/// <summary>
///Serialize 的摘要说明
/// </summary>
public class Serialize
{
    public Serialize()
    {
        //
        //TODO: 在此处添加构造函数逻辑
        //
    }
    /// <summary>序列化方法
    /// 不需要分页
    /// </summary>
    /// <param name="dt"></param>
    /// <param name="flag">false</param>
    /// <returns></returns>
    public static string SerializeByDataTable(DataTable dt, bool flag)
    {
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
        foreach (DataRow dr in dt.Rows)
        {
            Dictionary<string, object> result = new Dictionary<string, object>();
            foreach (DataColumn dc in dt.Columns)
            {
                result.Add(dc.ColumnName, dr[dc].ToString());
            }
            list.Add(result);
        }
        return serializer.Serialize(list); ;
    }

}
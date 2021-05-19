using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(GrocerStorePro.Startup))]
namespace GrocerStorePro
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}

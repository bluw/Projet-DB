using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using Projet_DB.Models;

namespace Projet_DB.Controllers
{
    public class ExpositionsController : ApiController
    {
        private MeditEntities db = new MeditEntities();

        [ResponseType(typeof(Exposition))]
        public IHttpActionResult PostExposition(ModelLibrary.Exposition newExposition)
        {
            if (!ModelState.IsValid) {
                return BadRequest(ModelState);
            }

            if (LinkExists(newExposition)) {
                return Conflict();
            }

            var exposition = new Exposition();
            fillExposition(exposition, newExposition);

            db.Expositions.Add(exposition);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = exposition.idExposition }, exposition);
        }

        private void fillExposition(Exposition expo, ModelLibrary.Exposition newExpo)
        {
            expo.FK_SubmittedJob = newExpo.FkJob;
            expo.FK_Risk = newExpo.FkRisk;
        }

        private bool LinkExists(ModelLibrary.Exposition expo)
        {
            return db.Expositions.Count(e => e.FK_Risk == expo.FkRisk && e.FK_SubmittedJob == expo.FkJob) > 0;
        }
    }
}
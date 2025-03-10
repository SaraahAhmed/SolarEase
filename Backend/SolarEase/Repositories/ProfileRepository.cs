﻿using SolarEase.Data;
using SolarEase.Models.Domain;
using Microsoft.EntityFrameworkCore;

namespace SolarEase.Repositories
{
    public class ProfileRepository : IProfileRepository
    {
        private readonly SolarEaseAuthDbContext dbContext;
        public ProfileRepository (SolarEaseAuthDbContext dbContext)
        {
            this.dbContext = dbContext;
        }
        
        public async Task<List<Profile>> GetAllAsync()
        {
            return await dbContext.Profiles.ToListAsync();
        }
        
        public async Task<Profile?> GetByIdAsync(int id)
        {
            return await dbContext.Profiles.FirstOrDefaultAsync(i => i.Id == id);
        }
        
        public async Task<Profile> CreateAsync(Profile profileModel)
        {
            await dbContext.Profiles.AddAsync(profileModel);
            await dbContext.SaveChangesAsync();
            return profileModel;
        }
        
        public async Task<Profile?> DeleteAsync(int id)
        {
            var profileModel = await dbContext.Profiles.FirstOrDefaultAsync(x => x.Id == id);
            if (profileModel == null)
            {
                return null;
            }
            dbContext.Profiles.Remove(profileModel);
            await dbContext.SaveChangesAsync();
            return profileModel;
        }
        
        public async Task<Profile?> UpdateAsync(int id, Profile profileModel)
        {
            var existingProfile = await dbContext.Profiles.FirstOrDefaultAsync(x => x.Id == id);
            if (existingProfile == null)
            {
                return null;
            }
            existingProfile.ImageUrl = profileModel.ImageUrl;

            await dbContext.SaveChangesAsync();
            return existingProfile;
        }
    }
}

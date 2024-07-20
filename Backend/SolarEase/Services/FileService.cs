using SolarEase.Models.Domain;
using Microsoft.AspNetCore.Hosting;

namespace SolarEase.Services
{
    public class FileService
    {
        private readonly IWebHostEnvironment webHostEnvironment;

        public FileService(IWebHostEnvironment webHostEnvironment)
        {
            this.webHostEnvironment = webHostEnvironment;
        }

        public string? UploadFile(string FolderName, IFormFile? newFile)
        {
            if (newFile != null && newFile.Length > 0)
            {
                // Generate a unique file name for the image
                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(newFile.FileName);
                // Define the path to save the image in your 'images' folder
                var filePath = Path.Combine(webHostEnvironment.WebRootPath, FolderName, fileName);
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    newFile.CopyTo(stream);
                }
                return filePath;
            }
            return null;

        }

        /*public string? UploadFile(string folderName, IFormFile? newFile)
        {
            if (newFile != null && newFile.Length > 0)
            {
                // Generate a unique file name for the image
                var fileName = Guid.NewGuid().ToString() + Path.GetExtension(newFile.FileName);
                // Define the path to save the image in your 'images' folder
                var filePath = Path.Combine(webHostEnvironment.WebRootPath, folderName, fileName);
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    newFile.CopyTo(stream);
                }
                // Construct the URL to access the file
                var fileUrl = Path.Combine("/", folderName, fileName).Replace("\\", "/");
                return fileUrl;
            }
            return null;
        }*/

        /*public string? UploadFile(string FolderName, IFormFile ufile)
        {
            if (ufile != null && ufile.Length > 0)
            {
                var fileName = Path.GetFileName(ufile.FileName);
                var filePath = Path.Combine(Directory.GetCurrentDirectory(), @"wwwroot\" + FolderName, fileName);
                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    ufile.CopyTo(fileStream);
                }
                return filePath;
            }
            return null;
        }*/

        public void DeleteFile(string filePath)
        {
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }
        }

        public string? UpdateFile(string FolderName, IFormFile? newFile, string? oldFilePath)
        {
            DeleteFile(oldFilePath);

            if (newFile != null)
            {
                return UploadFile(FolderName, newFile);
            }

            return null;

        }

    }
}

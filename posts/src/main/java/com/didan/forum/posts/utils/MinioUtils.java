package com.didan.forum.posts.utils;


import com.didan.forum.posts.exception.ErrorActionException;
import io.minio.BucketExistsArgs;
import io.minio.CopyObjectArgs;
import io.minio.CopySource;
import io.minio.GetBucketPolicyArgs;
import io.minio.GetObjectArgs;
import io.minio.GetPresignedObjectUrlArgs;
import io.minio.ListObjectsArgs;
import io.minio.MakeBucketArgs;
import io.minio.MinioClient;
import io.minio.ObjectWriteResponse;
import io.minio.PutObjectArgs;
import io.minio.RemoveBucketArgs;
import io.minio.RemoveObjectArgs;
import io.minio.Result;
import io.minio.StatObjectArgs;
import io.minio.StatObjectResponse;
import io.minio.UploadObjectArgs;
import io.minio.http.Method;
import io.minio.messages.Bucket;
import io.minio.messages.DeleteObject;
import io.minio.messages.Item;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Base64;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

@Component
@Slf4j
@RequiredArgsConstructor
public class MinioUtils {

  private final MinioClient minioClient;

  /* ------- Bucket Operations ------- */
  public void createBucket(String bucketName) {
    try {
      if (!bucketExists(bucketName)) {
        minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
      }
    } catch (Exception e) {
      log.error("Error creating bucket: {}", e.getMessage());
      throw new ErrorActionException("Error creating bucket: " + e.getMessage());
    }
  }

  public boolean bucketExists(String bucketName) {
    try {
      boolean check = minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
      log.info("check is {}", check);
      return check;
    } catch (Exception e) {
      log.error("Error checking bucket existence: {}", e.getMessage());
      throw new ErrorActionException("Error checking bucket existence: " + e.getMessage());
    }
  }

  public String getBucketPolicy(String bucketName) {
    try {
      return minioClient.getBucketPolicy(
          GetBucketPolicyArgs.builder()
              .bucket(bucketName)
              .build()
      );
    } catch (Exception e) {
      log.error("Error getting bucket policy: {}", e.getMessage());
      throw new ErrorActionException("Error getting bucket policy: " + e.getMessage());
    }
  }

  public List<Bucket> getAllBuckets() {
    try {
      return minioClient.listBuckets();
    } catch (Exception e) {
      log.error("Error getting all buckets: {}", e.getMessage());
      throw new ErrorActionException("Error getting all buckets: " + e.getMessage());
    }
  }

  public Optional<Bucket> getBucket(String bucketName) {
    try {
      return getAllBuckets().stream().filter(b -> b.name().equals(bucketName)).findFirst();
    } catch (Exception e) {
      log.error("Error getting bucket: {}", e.getMessage());
      throw new ErrorActionException("Error getting bucket: " + e.getMessage());
    }
  }

  public void removeBucket(String bucketName) {
    try {
      minioClient.removeBucket(
          RemoveBucketArgs.builder()
              .bucket(bucketName)
              .build()
      );
    } catch (Exception e) {
      log.error("Error removing bucket: {}", e.getMessage());
      throw new ErrorActionException("Error removing bucket: " + e.getMessage());
    }
  }

  /* ------- File Operations ------- */
  public boolean isObjectExists(String bucketName, String objectName) {
    try {
      minioClient.statObject(StatObjectArgs.builder()
          .bucket(bucketName)
          .object(objectName)
          .build());
    } catch (Exception e) {
      log.error("Error checking object existence: {}", e.getMessage());
      throw new ErrorActionException("Error checking object existence: " + e.getMessage());
    }
    return true;
  }

  public boolean isFolderExists(String bucketName, String folderName) {
    boolean exist = false;
    try {
      Iterable<Result<Item>> results = minioClient.listObjects(
          ListObjectsArgs.builder()
              .bucket(bucketName)
              .prefix(folderName)
              .recursive(false)
              .build()
      );
      for (Result<Item> result : results) {
        Item item = result.get();
        if (item.isDir() && folderName.equals(item.objectName())) {
          exist = true;
        }
      }
    } catch (Exception e) {
      log.error("Error checking folder existence: {}", e.getMessage());
      throw new ErrorActionException("Error checking folder existence: " + e.getMessage());
    }
    return exist;
  }

  public List<Item> getAllObjectsByPrefix(String bucketName, String prefix, boolean recursive) {
    List<Item> list = new ArrayList<>();
    Iterable<Result<Item>> objectsIterator = minioClient.listObjects(
        ListObjectsArgs.builder()
            .bucket(bucketName)
            .prefix(prefix)
            .recursive(recursive)
            .build()
    );
    if (objectsIterator != null) {
      objectsIterator.forEach(result -> {
        try {
          list.add(result.get());
        } catch (Exception e) {
          log.error("Error getting all objects by prefix: {}", e.getMessage());
          throw new ErrorActionException("Error getting all objects by prefix: " + e.getMessage());
        }
      });
    }
    return list;
  }

  public InputStream getObject(String bucketName, String objectName) {
    try {
      return minioClient.getObject(
          GetObjectArgs.builder()
              .bucket(bucketName)
              .object(objectName)
              .build()
      );
    } catch (Exception e) {
      log.error("Error getting object: {}", e.getMessage());
      throw new ErrorActionException("Error getting object: " + e.getMessage());
    }
  }

  public InputStream getObject(String bucketName, String objectName, long offset, long length) {
    try {
      return minioClient.getObject(
          GetObjectArgs.builder()
              .bucket(bucketName)
              .object(objectName)
              .offset(offset)
              .length(length)
              .build()
      );
    } catch (Exception e) {
      log.error("Error getting object: {}", e.getMessage());
      throw new ErrorActionException("Error getting object: " + e.getMessage());
    }
  }

  public Iterable<Result<Item>> listObjects(String bucketName, String prefix, boolean recursive) {
    try {
      return minioClient.listObjects(
          ListObjectsArgs.builder()
              .bucket(bucketName)
              .prefix(prefix)
              .recursive(recursive)
              .build()
      );
    } catch (Exception e) {
      log.error("Error listing objects: {}", e.getMessage());
      throw new ErrorActionException("Error listing objects: " + e.getMessage());
    }
  }

  public ObjectWriteResponse uploadFile(String bucketName, MultipartFile file, String objectName, String contentType) {
    try {
      InputStream inputStream = file.getInputStream();
      return minioClient.putObject(
          PutObjectArgs.builder()
              .bucket(bucketName)
              .object(objectName)
              .contentType(contentType)
              .stream(inputStream, inputStream.available(), -1)
              .build()
      );
    } catch (Exception e) {
      log.error("Error uploading file: {}", e.getMessage());
      throw new ErrorActionException("Error uploading file: " + e.getMessage());
    }
  }

  public ObjectWriteResponse uploadFile(String bucketName, String objectName, String contentType) {
    try {
      return minioClient.uploadObject(
          UploadObjectArgs.builder()
              .bucket(bucketName)
              .object(objectName)
              .filename(objectName)
              .build()
      );
    } catch (Exception e) {
      log.error("Error uploading file: {}", e.getMessage());
      throw new ErrorActionException("Error uploading file: " + e.getMessage());
    }
  }

  public ObjectWriteResponse uploadFile(String bucketName, String objectName, InputStream inputStream) {
    try {
      return minioClient.putObject(
          PutObjectArgs.builder()
              .bucket(bucketName)
              .object(objectName)
              .stream(inputStream, inputStream.available(), -1)
              .build()
      );
    } catch (Exception e) {
      log.error("Error uploading file: {}", e.getMessage());
      throw new ErrorActionException("Error uploading file: " + e.getMessage());
    }
  }

  public ObjectWriteResponse uploadImage(String bucketName, String imageBase64, String imageName) {
    try {
      if (!StringUtils.hasText(imageBase64)) {
        InputStream inputStream = base64ToInputStream(imageBase64);
        String newName = System.currentTimeMillis() + "_" + imageName + ".jpg";
        String year = String.valueOf(LocalDate.now().getYear());
        String month = String.valueOf(LocalDate.now().getMonthValue());
        return uploadFile(bucketName, year + "/" + month + "/" + newName, inputStream);
      }
      return null;
    } catch (Exception e) {
      log.error("Error uploading image: {}", e.getMessage());
      throw new ErrorActionException("Error uploading image: " + e.getMessage());
    }
  }

  public static InputStream base64ToInputStream(String base64) {
    ByteArrayInputStream stream = null;
    try {
      byte[] bytes = Base64.getDecoder().decode(base64.trim());
      stream = new ByteArrayInputStream(bytes);
    } catch (Exception e) {
      log.error("Error converting base64 to input stream: {}", e.getMessage());
      throw new ErrorActionException("Error converting base64 to input stream: " + e.getMessage());
    }
    return stream;
  }

  public ObjectWriteResponse createDir(String bucketName, String objectName) {
    try {
      return minioClient.putObject(
          PutObjectArgs.builder()
              .bucket(bucketName)
              .object(objectName)
              .stream(new ByteArrayInputStream(new byte[]{}), 0, -1)
              .build()
      );
    } catch (Exception e) {
      log.error("Error creating directory: {}", e.getMessage());
      throw new ErrorActionException("Error creating directory: " + e.getMessage());
    }
  }

  public StatObjectResponse getFileStatusInfo(String bucketName, String objectName) {
    try {
      return minioClient.statObject(
          StatObjectArgs.builder()
              .bucket(bucketName)
              .object(objectName)
              .build()
      );
    } catch (Exception e) {
      log.error("Error getting file status info: {}", e.getMessage());
      throw new ErrorActionException("Error getting file status info: " + e.getMessage());
    }
  }

  public ObjectWriteResponse copyFile(String bucketName, String objectName, String srcBucketName, String srcObjectName) {
    try {
      return minioClient.copyObject(
          CopyObjectArgs.builder()
              .source(CopySource.builder().bucket(bucketName).object(objectName).build())
              .bucket(srcBucketName)
              .object(srcObjectName)
              .build()
      );
    } catch (Exception e) {
      log.error("Error copying file: {}", e.getMessage());
      throw new ErrorActionException("Error copying file: " + e.getMessage());
    }
  }

  public void removeFile(String bucketName, String objectName) {
    try {
      minioClient.removeObject(
          RemoveObjectArgs.builder()
              .bucket(bucketName)
              .object(objectName)
              .build()
      );
    } catch (Exception e) {
      log.error("Error removing file: {}", e.getMessage());
      throw new ErrorActionException("Error removing file: " + e.getMessage());
    }
  }

  public void removeFile(String bucketName, List<String> keys) {
    List<DeleteObject> objects = new LinkedList<>();
    keys.forEach(key -> {
      objects.add(new DeleteObject(key));
      try {
        removeFile(bucketName, key);
      } catch (Exception e) {
        log.error("Error removing file: {}", e.getMessage());
        throw new ErrorActionException("Error removing file: " + e.getMessage());
      }
    });
  }

  public String getPresignedObjectUrl(String bucketName, String objectName) {
    try {
      GetPresignedObjectUrlArgs args = GetPresignedObjectUrlArgs.builder()
          .method(Method.GET)
          .bucket(bucketName)
          .object(objectName)
          .build();
      return minioClient.getPresignedObjectUrl(args);
    } catch (Exception e) {
      log.error("Error getting presigned object URL: {}", e.getMessage());
      throw new ErrorActionException("Error getting presigned object URL: " + e.getMessage());
    }
  }

  public String getUTF8ByURLDecoder(String str) {
    try {
      String url = str.replaceAll("%(?![0-9a-fA-F]{2})", "%25");
      return URLDecoder.decode(url, StandardCharsets.UTF_8);
    } catch (Exception e) {
      log.error("Error getting UTF-8 by URL decoder: {}", e.getMessage());
      throw new ErrorActionException("Error getting UTF-8 by URL decoder: " + e.getMessage());
    }
  }
}

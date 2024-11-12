CREATE DATABASE  IF NOT EXISTS `keycloakdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `keycloakdb`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: keycloakdb
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ADMIN_EVENT_ENTITY`
--

DROP TABLE IF EXISTS `ADMIN_EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ADMIN_EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `ADMIN_EVENT_TIME` bigint DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `OPERATION_TYPE` varchar(255) DEFAULT NULL,
  `AUTH_REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_CLIENT_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `RESOURCE_PATH` text,
  `REPRESENTATION` text,
  `ERROR` varchar(255) DEFAULT NULL,
  `RESOURCE_TYPE` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ADMIN_EVENT_TIME` (`REALM_ID`,`ADMIN_EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADMIN_EVENT_ENTITY`
--

LOCK TABLES `ADMIN_EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `ADMIN_EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ASSOCIATED_POLICY`
--

DROP TABLE IF EXISTS `ASSOCIATED_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ASSOCIATED_POLICY` (
  `POLICY_ID` varchar(36) NOT NULL,
  `ASSOCIATED_POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`POLICY_ID`,`ASSOCIATED_POLICY_ID`),
  KEY `IDX_ASSOC_POL_ASSOC_POL_ID` (`ASSOCIATED_POLICY_ID`),
  CONSTRAINT `FK_FRSR5S213XCX4WNKOG82SSRFY` FOREIGN KEY (`ASSOCIATED_POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPAS14XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ASSOCIATED_POLICY`
--

LOCK TABLES `ASSOCIATED_POLICY` WRITE;
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `ASSOCIATED_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_EXECUTION`
--

DROP TABLE IF EXISTS `AUTHENTICATION_EXECUTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATION_EXECUTION` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `AUTHENTICATOR` varchar(36) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `REQUIREMENT` int DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  `AUTHENTICATOR_FLOW` tinyint NOT NULL DEFAULT '0',
  `AUTH_FLOW_ID` varchar(36) DEFAULT NULL,
  `AUTH_CONFIG` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_EXEC_REALM_FLOW` (`REALM_ID`,`FLOW_ID`),
  KEY `IDX_AUTH_EXEC_FLOW` (`FLOW_ID`),
  CONSTRAINT `FK_AUTH_EXEC_FLOW` FOREIGN KEY (`FLOW_ID`) REFERENCES `AUTHENTICATION_FLOW` (`ID`),
  CONSTRAINT `FK_AUTH_EXEC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_EXECUTION`
--

LOCK TABLES `AUTHENTICATION_EXECUTION` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_EXECUTION` VALUES ('00fbe10d-418b-458d-aa61-632e5e4456f9',NULL,'client-x509','15e56e88-e77b-45e1-afa4-0d9a64309354','2167cc44-efb2-4167-ae7a-d5c91fe6e546',2,40,0,NULL,NULL),('0341241a-eb17-4f7d-8ea7-d41779d29465',NULL,'http-basic-authenticator','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','1bf72875-2239-47b8-a95d-4922e02b2228',0,10,0,NULL,NULL),('037cb57a-1b21-499c-997d-70b6a0a0ed5d',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ce49cba2-a7df-4994-99c4-5309c1f3fae3',1,30,1,'646ed00f-b362-4653-bfc2-39efdd354b8d',NULL),('05a47aaf-bdba-44d6-986f-1c5386ab142d',NULL,'auth-username-password-form','15e56e88-e77b-45e1-afa4-0d9a64309354','a33b28d1-c5e0-41e3-9b36-cc53f33923f0',0,10,0,NULL,NULL),('071112ff-719e-4946-b8e2-f026c50ac0e0',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','1a13a6ba-a1f7-47c3-b148-6189e265f6da',2,30,1,'643dd4b6-a076-46d0-821b-e0da68627bd4',NULL),('080e686d-222c-4af1-ac34-90f170123d0a',NULL,'registration-terms-and-conditions','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','3dab0ca8-06fa-477a-b871-a8f6ad3c3884',3,70,0,NULL,NULL),('0a6ab119-e159-46fb-877c-fddf3d974251',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','21ac8d4a-a7ee-4f15-94a2-bf283cd032d2',0,20,1,'e232e4ee-e8a3-4317-8151-a6ad40673104',NULL),('0ddbb92c-00f8-4456-ae66-c2aea594223d',NULL,'registration-recaptcha-action','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','3dab0ca8-06fa-477a-b871-a8f6ad3c3884',3,60,0,NULL,NULL),('1131eec5-c7d2-456b-ab70-3f67151a71cf',NULL,'docker-http-basic-authenticator','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','360e6019-57a9-45f4-be34-89bdba03631b',0,10,0,NULL,NULL),('148d8787-10d1-4ef2-a5a0-4c9c7bc875a3',NULL,'docker-http-basic-authenticator','15e56e88-e77b-45e1-afa4-0d9a64309354','13807a8e-4855-440e-ab00-4099e76f425f',0,10,0,NULL,NULL),('156fe7f7-2dca-4a03-bd44-678490a11e50',NULL,'registration-terms-and-conditions','15e56e88-e77b-45e1-afa4-0d9a64309354','d81aeef1-41ad-4758-b281-cd58b4354218',3,70,0,NULL,NULL),('15ba4a46-8d2a-4287-8667-e728d92aae33',NULL,'auth-cookie','15e56e88-e77b-45e1-afa4-0d9a64309354','04a2e250-5e3f-4eb8-8ad1-0149b53e38e0',2,10,0,NULL,NULL),('16d3d89e-167d-4d2f-9fb3-931fad6068c4',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','50aa52b9-ed04-4f5a-8ad3-c0e6f0d0507d',2,20,1,'a193166c-2fbd-4a77-937b-ba7b9f5161b5',NULL),('17fe23a9-648d-4b91-b676-cc7eb2c25856',NULL,'idp-confirm-link','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','90b7cdfd-54af-4012-a69e-64b41d19055a',0,10,0,NULL,NULL),('19140a02-6044-4a30-b5c3-5d4b223bd3cc',NULL,'reset-credential-email','15e56e88-e77b-45e1-afa4-0d9a64309354','a249d63e-f82a-4ff7-a4ae-132f2a6f9232',0,20,0,NULL,NULL),('1c3ac8a4-1900-4282-87b5-c006bff79240',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','e232e4ee-e8a3-4317-8151-a6ad40673104',2,20,1,'1f5cfa2e-7675-4df4-bcfe-37b8312eb3b1',NULL),('1c8d70bd-1d85-49c4-8571-0e9f69bc66fd',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','643dd4b6-a076-46d0-821b-e0da68627bd4',1,20,1,'43e48f0d-6711-41ad-8b89-a2b8abf605e2',NULL),('1dbc3d22-ad65-4d12-85ae-73b9d4de10e6',NULL,'idp-username-password-form','f65da957-0a1a-47d4-9781-0118b7c15e3d','1f5cfa2e-7675-4df4-bcfe-37b8312eb3b1',0,10,0,NULL,NULL),('1e827847-a128-437c-b5c2-c09cefdf00d1',NULL,'idp-confirm-link','15e56e88-e77b-45e1-afa4-0d9a64309354','302d194a-8f0a-4edb-a71e-1a372385c6da',0,10,0,NULL,NULL),('214c13bc-edbc-496e-8e1b-8c9464676ea7',NULL,'idp-username-password-form','15e56e88-e77b-45e1-afa4-0d9a64309354','a193166c-2fbd-4a77-937b-ba7b9f5161b5',0,10,0,NULL,NULL),('216c404b-91ec-4c47-89d9-732456d4b42d',NULL,'direct-grant-validate-password','15e56e88-e77b-45e1-afa4-0d9a64309354','2c1b348d-12ca-4d9f-af35-f127cb7a7929',0,20,0,NULL,NULL),('222f5c42-4695-4807-8a12-bfafbcf222b8',NULL,'idp-create-user-if-unique','15e56e88-e77b-45e1-afa4-0d9a64309354','bed6e39e-e5ec-410d-9ba3-8c10a7d0e4c9',2,10,0,NULL,'c46fe620-5ec7-46dc-bc85-d37432ec6303'),('2362a243-a3f5-40fb-9c77-bee0b3a53cd9',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','600d10af-9eea-4fcb-bbb6-0591e021578a',2,20,1,'90b7cdfd-54af-4012-a69e-64b41d19055a',NULL),('23d055ef-98dd-4bd4-8fa0-1cb2e4b15933',NULL,'http-basic-authenticator','15e56e88-e77b-45e1-afa4-0d9a64309354','004a5c8a-e9c9-4448-9ccd-62bebb55bb6d',0,10,0,NULL,NULL),('24ed5b17-b53c-4bdc-b345-84eba8bcf7e3',NULL,'registration-page-form','f65da957-0a1a-47d4-9781-0118b7c15e3d','d19c076d-9f45-403e-b274-a1e5965ffabf',0,10,1,'9473c7cf-ec8b-456f-8266-72cc50d517f0',NULL),('24f5e785-36e4-435c-86df-721328a1755c',NULL,'idp-review-profile','f65da957-0a1a-47d4-9781-0118b7c15e3d','2a2bbd2e-7755-4fa3-91e8-b634d1923b77',0,10,0,NULL,'2254e3dd-5b7c-4ea9-bd7b-5bc2b292fec8'),('26233f2f-f48f-40a6-b2d6-cee5eb0c39ad',NULL,'auth-spnego','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','1a13a6ba-a1f7-47c3-b148-6189e265f6da',3,20,0,NULL,NULL),('28848fff-dda4-416e-9e01-df027f3f3acb',NULL,'conditional-user-configured','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','713537ce-15c3-4a21-8f5a-182427e57dcb',0,10,0,NULL,NULL),('288fcc07-8df5-465d-9596-5b6b8ed6e909',NULL,'client-secret-jwt','f65da957-0a1a-47d4-9781-0118b7c15e3d','0bc778f0-74bd-4d03-9855-912221d0e720',2,30,0,NULL,NULL),('2af46cf8-4c0a-486d-ad28-788cb9aad9cc',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','a193166c-2fbd-4a77-937b-ba7b9f5161b5',1,20,1,'ba8c8ce9-5995-432c-8802-f2465f429770',NULL),('2b15b976-f398-4c41-8b34-0411f511c484',NULL,'client-secret','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ed269c54-83da-4673-941f-423fdcdecf89',2,10,0,NULL,NULL),('2fa8db76-62b6-4b56-8001-1069790cde9b',NULL,'reset-credentials-choose-user','f65da957-0a1a-47d4-9781-0118b7c15e3d','b38342c1-0f66-4753-8022-1d8cc2a126ac',0,10,0,NULL,NULL),('320d4a03-ef92-442e-b444-9e84e7df1efa',NULL,'conditional-user-configured','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','646ed00f-b362-4653-bfc2-39efdd354b8d',0,10,0,NULL,NULL),('34d1ea57-4176-4f78-8aaf-5593bf1e6e64',NULL,'client-x509','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ed269c54-83da-4673-941f-423fdcdecf89',2,40,0,NULL,NULL),('365a55b2-f9f0-4509-8d8c-8c2a54b6c52a',NULL,'reset-credentials-choose-user','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','fc2d16aa-f436-4b9b-9af7-08826e2b35c6',0,10,0,NULL,NULL),('36e30ba2-daa9-4337-b5f5-985b1499019b',NULL,'registration-password-action','15e56e88-e77b-45e1-afa4-0d9a64309354','d81aeef1-41ad-4758-b281-cd58b4354218',0,50,0,NULL,NULL),('37cbbaed-eb69-4c00-a4c2-2695a12e25b2',NULL,'auth-cookie','f65da957-0a1a-47d4-9781-0118b7c15e3d','9403ca4f-e9d7-436a-b01a-1d19bcd4ba13',2,10,0,NULL,NULL),('3e4f087e-7877-4661-a227-4d014874bd6e',NULL,'idp-create-user-if-unique','f65da957-0a1a-47d4-9781-0118b7c15e3d','4bfa13f0-1387-4ea5-bab4-3d394d066ef9',2,10,0,NULL,'c81e00e4-bbc4-4e9e-8c1c-75a9d3a637ba'),('3e9040e0-217c-4c40-8c7b-796386d11b51',NULL,'auth-username-password-form','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','643dd4b6-a076-46d0-821b-e0da68627bd4',0,10,0,NULL,NULL),('44107a55-c46a-4f14-94ec-91883a04f6db',NULL,'auth-otp-form','15e56e88-e77b-45e1-afa4-0d9a64309354','ba8c8ce9-5995-432c-8802-f2465f429770',0,20,0,NULL,NULL),('44770c74-23a5-43b1-ab9d-d2109a79bbac',NULL,'reset-credentials-choose-user','15e56e88-e77b-45e1-afa4-0d9a64309354','a249d63e-f82a-4ff7-a4ae-132f2a6f9232',0,10,0,NULL,NULL),('4c9f5c1e-f54c-4f7d-b717-6996b8ec3f9d',NULL,'auth-spnego','15e56e88-e77b-45e1-afa4-0d9a64309354','04a2e250-5e3f-4eb8-8ad1-0149b53e38e0',3,20,0,NULL,NULL),('4dff13a7-84ab-4c73-bad8-596a6bced12d',NULL,'auth-username-password-form','f65da957-0a1a-47d4-9781-0118b7c15e3d','792d3828-be4f-4678-882e-74ebfd65c15f',0,10,0,NULL,NULL),('52393da2-a25e-4979-9819-02a3b07a8933',NULL,'client-secret','f65da957-0a1a-47d4-9781-0118b7c15e3d','0bc778f0-74bd-4d03-9855-912221d0e720',2,10,0,NULL,NULL),('537bb292-1181-4b29-900f-2db27c884270',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','2c1b348d-12ca-4d9f-af35-f127cb7a7929',1,30,1,'904f57e4-116e-4a7a-9506-abec46c6bc2b',NULL),('5384a46c-5ed9-4d21-8038-f8c081d95384',NULL,'auth-spnego','f65da957-0a1a-47d4-9781-0118b7c15e3d','9403ca4f-e9d7-436a-b01a-1d19bcd4ba13',3,20,0,NULL,NULL),('57de14a3-7a91-47a9-8610-ea693e52e33e',NULL,'idp-email-verification','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','18f0291b-dcde-4469-b65b-3716aa3c4e02',2,10,0,NULL,NULL),('5964a691-5b6f-45c4-97b1-3d72ff01135c',NULL,'reset-otp','f65da957-0a1a-47d4-9781-0118b7c15e3d','be074d46-c780-4226-8eec-2c10a201ba93',0,20,0,NULL,NULL),('5a1449d3-c86e-4b18-b0f7-89c63f368bf4',NULL,'registration-terms-and-conditions','f65da957-0a1a-47d4-9781-0118b7c15e3d','9473c7cf-ec8b-456f-8266-72cc50d517f0',3,70,0,NULL,NULL),('5d0585bc-e206-4376-a6ae-dfbf62127952',NULL,'auth-cookie','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','1a13a6ba-a1f7-47c3-b148-6189e265f6da',2,10,0,NULL,NULL),('62075b1c-76f7-43a1-8901-34cc5c3d3e79',NULL,'registration-page-form','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','9ab7f66f-07f5-4353-a501-5c5fb4f496e7',0,10,1,'3dab0ca8-06fa-477a-b871-a8f6ad3c3884',NULL),('624c3ac6-c350-4f78-a27c-fad97a9eef0c',NULL,'registration-user-creation','15e56e88-e77b-45e1-afa4-0d9a64309354','d81aeef1-41ad-4758-b281-cd58b4354218',0,20,0,NULL,NULL),('63195c33-b004-4bc3-b811-90bc4c32e9a3',NULL,'idp-confirm-link','f65da957-0a1a-47d4-9781-0118b7c15e3d','21ac8d4a-a7ee-4f15-94a2-bf283cd032d2',0,10,0,NULL,NULL),('63fdb38f-ff8f-48ca-8483-3719a17288c4',NULL,'conditional-user-configured','15e56e88-e77b-45e1-afa4-0d9a64309354','e56a1cb0-b387-4e63-90e0-f67d6ce2116d',0,10,0,NULL,NULL),('6504d4fe-e5a9-495d-aff5-60c0a3a2e232',NULL,'idp-email-verification','15e56e88-e77b-45e1-afa4-0d9a64309354','50aa52b9-ed04-4f5a-8ad3-c0e6f0d0507d',2,10,0,NULL,NULL),('66b9ee70-aaad-43af-9ff1-93fd271b5b72',NULL,'client-jwt','15e56e88-e77b-45e1-afa4-0d9a64309354','2167cc44-efb2-4167-ae7a-d5c91fe6e546',2,20,0,NULL,NULL),('682160c9-9aed-41d2-bd27-cd0ec1ed5d4b',NULL,'reset-password','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','fc2d16aa-f436-4b9b-9af7-08826e2b35c6',0,30,0,NULL,NULL),('6835dd97-e317-49d6-a079-70e4d859d051',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','a33b28d1-c5e0-41e3-9b36-cc53f33923f0',1,20,1,'e56a1cb0-b387-4e63-90e0-f67d6ce2116d',NULL),('68c14dd8-dba2-484e-82aa-daaf7f8b9074',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','fc2d16aa-f436-4b9b-9af7-08826e2b35c6',1,40,1,'713537ce-15c3-4a21-8f5a-182427e57dcb',NULL),('6f2f095d-04e2-450c-b642-a7f49f5b2039',NULL,'identity-provider-redirector','f65da957-0a1a-47d4-9781-0118b7c15e3d','9403ca4f-e9d7-436a-b01a-1d19bcd4ba13',2,25,0,NULL,NULL),('70acb649-1983-418b-9161-eb97ecf5fa23',NULL,'direct-grant-validate-otp','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','646ed00f-b362-4653-bfc2-39efdd354b8d',0,20,0,NULL,NULL),('70ba78a5-0946-4e52-ae62-a54a823117d3',NULL,'client-jwt','f65da957-0a1a-47d4-9781-0118b7c15e3d','0bc778f0-74bd-4d03-9855-912221d0e720',2,20,0,NULL,NULL),('734fdfbc-455d-4e0c-b9c7-a46fd7b86994',NULL,'idp-review-profile','15e56e88-e77b-45e1-afa4-0d9a64309354','b126c8f3-7f16-40b6-be8c-9722c4d31916',0,10,0,NULL,'05c863dd-b6f5-4c8a-be7b-253d1aca8dd3'),('7672896c-71ca-4584-9be2-924e5b60dc07',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','284b5531-820f-4e14-a14e-edd9a21e7d8f',1,20,1,'ef977c39-bfdb-45eb-8a49-0b436bffb434',NULL),('79c11a2a-98a4-4cde-9f97-5f511c5489ed',NULL,'direct-grant-validate-otp','f65da957-0a1a-47d4-9781-0118b7c15e3d','608d7e5a-cd0a-4714-802f-0daa4258ef58',0,20,0,NULL,NULL),('7c2f781a-5dbe-4df0-a210-b643af7f45b3',NULL,'idp-email-verification','f65da957-0a1a-47d4-9781-0118b7c15e3d','e232e4ee-e8a3-4317-8151-a6ad40673104',2,10,0,NULL,NULL),('7e4ad3ae-a07b-41f3-b2db-3028ed1dff08',NULL,'registration-user-creation','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','3dab0ca8-06fa-477a-b871-a8f6ad3c3884',0,20,0,NULL,NULL),('824f3533-104e-4cc9-988f-cdac7d87474b',NULL,'reset-otp','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','713537ce-15c3-4a21-8f5a-182427e57dcb',0,20,0,NULL,NULL),('82bbef9e-a0f3-4299-ab12-36c4cf2443aa',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','bed6e39e-e5ec-410d-9ba3-8c10a7d0e4c9',2,20,1,'302d194a-8f0a-4edb-a71e-1a372385c6da',NULL),('858a9e2f-7d96-4b70-93b2-c59ececde29a',NULL,'conditional-user-configured','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ef977c39-bfdb-45eb-8a49-0b436bffb434',0,10,0,NULL,NULL),('88fa99c5-519d-495d-bd98-2f52b83ea9b8',NULL,'direct-grant-validate-otp','15e56e88-e77b-45e1-afa4-0d9a64309354','904f57e4-116e-4a7a-9506-abec46c6bc2b',0,20,0,NULL,NULL),('8b3b4374-76c2-4124-8b60-abf6797aac2b',NULL,'registration-user-creation','f65da957-0a1a-47d4-9781-0118b7c15e3d','9473c7cf-ec8b-456f-8266-72cc50d517f0',0,20,0,NULL,NULL),('8be0262f-651e-423b-a27b-3c01a791db4b',NULL,'reset-password','15e56e88-e77b-45e1-afa4-0d9a64309354','a249d63e-f82a-4ff7-a4ae-132f2a6f9232',0,30,0,NULL,NULL),('8beabd2b-ecaf-408a-b428-2a54839ec02d',NULL,'idp-review-profile','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ac578b97-839e-4d63-a7a1-2ca31920c6f1',0,10,0,NULL,'2602a574-d569-4131-9744-b8035d96f1e8'),('8e70cad4-0e13-47ac-a330-72e6b23ba90d',NULL,'direct-grant-validate-password','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ce49cba2-a7df-4994-99c4-5309c1f3fae3',0,20,0,NULL,NULL),('8f68a0a2-b87a-4899-a6f1-c8cb080b29a9',NULL,'reset-credential-email','f65da957-0a1a-47d4-9781-0118b7c15e3d','b38342c1-0f66-4753-8022-1d8cc2a126ac',0,20,0,NULL,NULL),('905ef992-fc28-4f4d-83ec-c3aca7386d74',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','4bfa13f0-1387-4ea5-bab4-3d394d066ef9',2,20,1,'21ac8d4a-a7ee-4f15-94a2-bf283cd032d2',NULL),('907ecf73-7f7f-4d15-9906-14bd288bc74b',NULL,'client-x509','f65da957-0a1a-47d4-9781-0118b7c15e3d','0bc778f0-74bd-4d03-9855-912221d0e720',2,40,0,NULL,NULL),('91f9c867-33fa-4557-9943-7d67e8e9801a',NULL,'client-secret-jwt','15e56e88-e77b-45e1-afa4-0d9a64309354','2167cc44-efb2-4167-ae7a-d5c91fe6e546',2,30,0,NULL,NULL),('9258d578-695d-4af3-b243-03fc3317de40',NULL,'http-basic-authenticator','f65da957-0a1a-47d4-9781-0118b7c15e3d','41939f5a-f1e8-416d-97ae-fc19f4130cef',0,10,0,NULL,NULL),('956986cd-6613-4a35-8bc8-fe90d6d4c81a',NULL,'conditional-user-configured','f65da957-0a1a-47d4-9781-0118b7c15e3d','10194c8c-8c63-442b-806b-c033d0f28495',0,10,0,NULL,NULL),('96c530d8-2ed2-436b-ae21-59345d195aaf',NULL,'idp-create-user-if-unique','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','600d10af-9eea-4fcb-bbb6-0591e021578a',2,10,0,NULL,'ed42656d-2be1-4489-83d1-88cf4d5b3d7f'),('989dc054-c528-4da8-b4d3-e643b6168976',NULL,'direct-grant-validate-username','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ce49cba2-a7df-4994-99c4-5309c1f3fae3',0,10,0,NULL,NULL),('9d1f93ed-5160-469f-b44e-6a0f7318c571',NULL,'registration-recaptcha-action','f65da957-0a1a-47d4-9781-0118b7c15e3d','9473c7cf-ec8b-456f-8266-72cc50d517f0',3,60,0,NULL,NULL),('9ded608e-8c72-4146-974a-91379925b2af',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','90b7cdfd-54af-4012-a69e-64b41d19055a',0,20,1,'18f0291b-dcde-4469-b65b-3716aa3c4e02',NULL),('a0164c13-47a9-4b8b-8deb-c572cf3222e2',NULL,'direct-grant-validate-password','f65da957-0a1a-47d4-9781-0118b7c15e3d','e9fa2f24-b105-4430-8f57-fbd639b3e1c4',0,20,0,NULL,NULL),('a155c588-e4ac-4be9-bc60-6abfb144ead4',NULL,'client-jwt','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ed269c54-83da-4673-941f-423fdcdecf89',2,20,0,NULL,NULL),('a67e294c-311d-4f91-8bc0-64a10abbd75d',NULL,'reset-otp','15e56e88-e77b-45e1-afa4-0d9a64309354','a60fa799-188b-4751-a9e0-3f9edf3c9002',0,20,0,NULL,NULL),('a6d39417-bd88-454f-a1c1-41d99e5f505a',NULL,'conditional-user-configured','f65da957-0a1a-47d4-9781-0118b7c15e3d','608d7e5a-cd0a-4714-802f-0daa4258ef58',0,10,0,NULL,NULL),('ad23ae80-2c7d-47b9-944f-465fe68e2567',NULL,'identity-provider-redirector','15e56e88-e77b-45e1-afa4-0d9a64309354','04a2e250-5e3f-4eb8-8ad1-0149b53e38e0',2,25,0,NULL,NULL),('ae4b3162-a93b-48c0-83df-54ffb21d0a56',NULL,'reset-credential-email','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','fc2d16aa-f436-4b9b-9af7-08826e2b35c6',0,20,0,NULL,NULL),('afe87cd6-8164-469f-8aa3-d3870587879c',NULL,'direct-grant-validate-username','15e56e88-e77b-45e1-afa4-0d9a64309354','2c1b348d-12ca-4d9f-af35-f127cb7a7929',0,10,0,NULL,NULL),('b32246db-cbee-4a54-a8f9-5fb22e4f03f7',NULL,'auth-otp-form','15e56e88-e77b-45e1-afa4-0d9a64309354','e56a1cb0-b387-4e63-90e0-f67d6ce2116d',0,20,0,NULL,NULL),('b487ed28-e0f8-452b-ac93-e274aa4803cd',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','b38342c1-0f66-4753-8022-1d8cc2a126ac',1,40,1,'be074d46-c780-4226-8eec-2c10a201ba93',NULL),('b4f3681d-5081-4b09-b91f-95205ff177ef',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','b126c8f3-7f16-40b6-be8c-9722c4d31916',0,20,1,'bed6e39e-e5ec-410d-9ba3-8c10a7d0e4c9',NULL),('b8427b85-3749-4a21-9bb4-e8c1fb24963f',NULL,'registration-recaptcha-action','15e56e88-e77b-45e1-afa4-0d9a64309354','d81aeef1-41ad-4758-b281-cd58b4354218',3,60,0,NULL,NULL),('b8529fbc-a5f3-40ef-94bf-5225ef9ff524',NULL,'registration-password-action','f65da957-0a1a-47d4-9781-0118b7c15e3d','9473c7cf-ec8b-456f-8266-72cc50d517f0',0,50,0,NULL,NULL),('b968920c-447b-4c33-8151-a43dc500f7e4',NULL,'conditional-user-configured','15e56e88-e77b-45e1-afa4-0d9a64309354','a60fa799-188b-4751-a9e0-3f9edf3c9002',0,10,0,NULL,NULL),('bc9b7c28-976b-492a-bfd7-a37597b50fc9',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','a249d63e-f82a-4ff7-a4ae-132f2a6f9232',1,40,1,'a60fa799-188b-4751-a9e0-3f9edf3c9002',NULL),('bda6d354-48b6-41a5-8998-a701527a1fca',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','302d194a-8f0a-4edb-a71e-1a372385c6da',0,20,1,'50aa52b9-ed04-4f5a-8ad3-c0e6f0d0507d',NULL),('c0ba53a3-92b1-40df-9d2d-d39bee7779a9',NULL,'identity-provider-redirector','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','1a13a6ba-a1f7-47c3-b148-6189e265f6da',2,25,0,NULL,NULL),('c95ff110-499a-4aac-b562-3416318a494f',NULL,'client-secret','15e56e88-e77b-45e1-afa4-0d9a64309354','2167cc44-efb2-4167-ae7a-d5c91fe6e546',2,10,0,NULL,NULL),('d270bc10-2fa5-451d-afb6-8b7baed0f7c4',NULL,'auth-otp-form','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','43e48f0d-6711-41ad-8b89-a2b8abf605e2',0,20,0,NULL,NULL),('d2c2f7e4-e2d1-4930-9c63-e42ff08d9365',NULL,'reset-password','f65da957-0a1a-47d4-9781-0118b7c15e3d','b38342c1-0f66-4753-8022-1d8cc2a126ac',0,30,0,NULL,NULL),('d2d4a68f-e3b0-48c8-b82f-284673d0dd16',NULL,'conditional-user-configured','15e56e88-e77b-45e1-afa4-0d9a64309354','904f57e4-116e-4a7a-9506-abec46c6bc2b',0,10,0,NULL,NULL),('d6ce1985-4a18-49a6-a84b-11f782ab8c24',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','18f0291b-dcde-4469-b65b-3716aa3c4e02',2,20,1,'284b5531-820f-4e14-a14e-edd9a21e7d8f',NULL),('d8f74af8-e5ed-4a99-a95a-b4bb37c79029',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','2a2bbd2e-7755-4fa3-91e8-b634d1923b77',0,20,1,'4bfa13f0-1387-4ea5-bab4-3d394d066ef9',NULL),('d90518e4-3f3e-4259-975b-34dab9eb2dfd',NULL,'docker-http-basic-authenticator','f65da957-0a1a-47d4-9781-0118b7c15e3d','2e9db36b-062b-4ac0-9022-d245cb9d457d',0,10,0,NULL,NULL),('daa1eec2-f60f-43db-a889-f826ea2e2096',NULL,'conditional-user-configured','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','43e48f0d-6711-41ad-8b89-a2b8abf605e2',0,10,0,NULL,NULL),('db1cb6c3-7d97-4d55-a8b1-41bf631c72c7',NULL,'auth-otp-form','f65da957-0a1a-47d4-9781-0118b7c15e3d','10194c8c-8c63-442b-806b-c033d0f28495',0,20,0,NULL,NULL),('dcd48550-f6d6-4bf2-8307-100e4d29b324',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','1f5cfa2e-7675-4df4-bcfe-37b8312eb3b1',1,20,1,'10194c8c-8c63-442b-806b-c033d0f28495',NULL),('dce68033-fdcc-46b1-a5b7-ebf55db7a5b2',NULL,'conditional-user-configured','f65da957-0a1a-47d4-9781-0118b7c15e3d','681e6e89-2d25-4ae8-8263-ba2a93d1d04f',0,10,0,NULL,NULL),('de5366bf-5489-4f3f-89d8-522263313745',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','e9fa2f24-b105-4430-8f57-fbd639b3e1c4',1,30,1,'608d7e5a-cd0a-4714-802f-0daa4258ef58',NULL),('dec29b0c-a79e-45d1-933c-4d6f78829fe9',NULL,'registration-password-action','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','3dab0ca8-06fa-477a-b871-a8f6ad3c3884',0,50,0,NULL,NULL),('e40715ad-4393-4f41-9cff-2a22a3b3246e',NULL,'idp-username-password-form','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','284b5531-820f-4e14-a14e-edd9a21e7d8f',0,10,0,NULL,NULL),('e6adc624-9a34-4210-b2a6-b85124f2385c',NULL,'auth-otp-form','f65da957-0a1a-47d4-9781-0118b7c15e3d','681e6e89-2d25-4ae8-8263-ba2a93d1d04f',0,20,0,NULL,NULL),('e8182c9c-39ac-46df-af83-28b007e3b120',NULL,NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ac578b97-839e-4d63-a7a1-2ca31920c6f1',0,20,1,'600d10af-9eea-4fcb-bbb6-0591e021578a',NULL),('e891992d-457c-45c8-ada1-647a957cd801',NULL,'conditional-user-configured','f65da957-0a1a-47d4-9781-0118b7c15e3d','be074d46-c780-4226-8eec-2c10a201ba93',0,10,0,NULL,NULL),('ec975554-c8b7-4640-863f-183b7a0a6eee',NULL,'registration-page-form','15e56e88-e77b-45e1-afa4-0d9a64309354','845a07b8-ea1c-49d1-b83d-29fd2b16a5a4',0,10,1,'d81aeef1-41ad-4758-b281-cd58b4354218',NULL),('f4c48f0d-80fa-44fa-bfd4-53c639acb395',NULL,'conditional-user-configured','15e56e88-e77b-45e1-afa4-0d9a64309354','ba8c8ce9-5995-432c-8802-f2465f429770',0,10,0,NULL,NULL),('f91e737f-3c90-49d7-b5de-0eb6af5fe12c',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','9403ca4f-e9d7-436a-b01a-1d19bcd4ba13',2,30,1,'792d3828-be4f-4678-882e-74ebfd65c15f',NULL),('f978942f-c56c-4d13-a58d-7cc1eb913b3d',NULL,NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','04a2e250-5e3f-4eb8-8ad1-0149b53e38e0',2,30,1,'a33b28d1-c5e0-41e3-9b36-cc53f33923f0',NULL),('f9eeec7e-ddf9-49c6-af83-d8e805eaa36e',NULL,'auth-otp-form','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ef977c39-bfdb-45eb-8a49-0b436bffb434',0,20,0,NULL,NULL),('fb736d27-801c-4871-a3cc-6e19b142956d',NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','792d3828-be4f-4678-882e-74ebfd65c15f',1,20,1,'681e6e89-2d25-4ae8-8263-ba2a93d1d04f',NULL),('fbf882fa-e4fa-43e7-a0d0-09520d6d3c1e',NULL,'direct-grant-validate-username','f65da957-0a1a-47d4-9781-0118b7c15e3d','e9fa2f24-b105-4430-8f57-fbd639b3e1c4',0,10,0,NULL,NULL),('fface405-2c07-4846-a2d1-6424b86fc67d',NULL,'client-secret-jwt','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ed269c54-83da-4673-941f-423fdcdecf89',2,30,0,NULL,NULL);
/*!40000 ALTER TABLE `AUTHENTICATION_EXECUTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATION_FLOW`
--

DROP TABLE IF EXISTS `AUTHENTICATION_FLOW`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATION_FLOW` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) NOT NULL DEFAULT 'basic-flow',
  `TOP_LEVEL` tinyint NOT NULL DEFAULT '0',
  `BUILT_IN` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_FLOW_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_FLOW_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATION_FLOW`
--

LOCK TABLES `AUTHENTICATION_FLOW` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` DISABLE KEYS */;
INSERT INTO `AUTHENTICATION_FLOW` VALUES ('004a5c8a-e9c9-4448-9ccd-62bebb55bb6d','saml ecp','SAML ECP Profile Authentication Flow','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',1,1),('04a2e250-5e3f-4eb8-8ad1-0149b53e38e0','browser','browser based authentication','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',1,1),('0bc778f0-74bd-4d03-9855-912221d0e720','clients','Base authentication for clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','client-flow',1,1),('10194c8c-8c63-442b-806b-c033d0f28495','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('13807a8e-4855-440e-ab00-4099e76f425f','docker auth','Used by Docker clients to authenticate against the IDP','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',1,1),('18f0291b-dcde-4469-b65b-3716aa3c4e02','Account verification options','Method with which to verity the existing account','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('1a13a6ba-a1f7-47c3-b148-6189e265f6da','browser','browser based authentication','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',1,1),('1bf72875-2239-47b8-a95d-4922e02b2228','saml ecp','SAML ECP Profile Authentication Flow','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',1,1),('1f5cfa2e-7675-4df4-bcfe-37b8312eb3b1','Verify Existing Account by Re-authentication','Reauthentication of existing account','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('2167cc44-efb2-4167-ae7a-d5c91fe6e546','clients','Base authentication for clients','15e56e88-e77b-45e1-afa4-0d9a64309354','client-flow',1,1),('21ac8d4a-a7ee-4f15-94a2-bf283cd032d2','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('284b5531-820f-4e14-a14e-edd9a21e7d8f','Verify Existing Account by Re-authentication','Reauthentication of existing account','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('2a2bbd2e-7755-4fa3-91e8-b634d1923b77','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',1,1),('2c1b348d-12ca-4d9f-af35-f127cb7a7929','direct grant','OpenID Connect Resource Owner Grant','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',1,1),('2e9db36b-062b-4ac0-9022-d245cb9d457d','docker auth','Used by Docker clients to authenticate against the IDP','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',1,1),('302d194a-8f0a-4edb-a71e-1a372385c6da','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('360e6019-57a9-45f4-be34-89bdba03631b','docker auth','Used by Docker clients to authenticate against the IDP','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',1,1),('3dab0ca8-06fa-477a-b871-a8f6ad3c3884','registration form','registration form','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','form-flow',0,1),('41939f5a-f1e8-416d-97ae-fc19f4130cef','saml ecp','SAML ECP Profile Authentication Flow','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',1,1),('43e48f0d-6711-41ad-8b89-a2b8abf605e2','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('4bfa13f0-1387-4ea5-bab4-3d394d066ef9','User creation or linking','Flow for the existing/non-existing user alternatives','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('50aa52b9-ed04-4f5a-8ad3-c0e6f0d0507d','Account verification options','Method with which to verity the existing account','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('600d10af-9eea-4fcb-bbb6-0591e021578a','User creation or linking','Flow for the existing/non-existing user alternatives','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('608d7e5a-cd0a-4714-802f-0daa4258ef58','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('643dd4b6-a076-46d0-821b-e0da68627bd4','forms','Username, password, otp and other auth forms.','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('646ed00f-b362-4653-bfc2-39efdd354b8d','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('681e6e89-2d25-4ae8-8263-ba2a93d1d04f','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('713537ce-15c3-4a21-8f5a-182427e57dcb','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('792d3828-be4f-4678-882e-74ebfd65c15f','forms','Username, password, otp and other auth forms.','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('845a07b8-ea1c-49d1-b83d-29fd2b16a5a4','registration','registration flow','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',1,1),('904f57e4-116e-4a7a-9506-abec46c6bc2b','Direct Grant - Conditional OTP','Flow to determine if the OTP is required for the authentication','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('90b7cdfd-54af-4012-a69e-64b41d19055a','Handle Existing Account','Handle what to do if there is existing account with same email/username like authenticated identity provider','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('9403ca4f-e9d7-436a-b01a-1d19bcd4ba13','browser','browser based authentication','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',1,1),('9473c7cf-ec8b-456f-8266-72cc50d517f0','registration form','registration form','f65da957-0a1a-47d4-9781-0118b7c15e3d','form-flow',0,1),('9ab7f66f-07f5-4353-a501-5c5fb4f496e7','registration','registration flow','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',1,1),('a193166c-2fbd-4a77-937b-ba7b9f5161b5','Verify Existing Account by Re-authentication','Reauthentication of existing account','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('a249d63e-f82a-4ff7-a4ae-132f2a6f9232','reset credentials','Reset credentials for a user if they forgot their password or something','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',1,1),('a33b28d1-c5e0-41e3-9b36-cc53f33923f0','forms','Username, password, otp and other auth forms.','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('a60fa799-188b-4751-a9e0-3f9edf3c9002','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('ac578b97-839e-4d63-a7a1-2ca31920c6f1','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',1,1),('b126c8f3-7f16-40b6-be8c-9722c4d31916','first broker login','Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',1,1),('b38342c1-0f66-4753-8022-1d8cc2a126ac','reset credentials','Reset credentials for a user if they forgot their password or something','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',1,1),('ba8c8ce9-5995-432c-8802-f2465f429770','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('be074d46-c780-4226-8eec-2c10a201ba93','Reset - Conditional OTP','Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('bed6e39e-e5ec-410d-9ba3-8c10a7d0e4c9','User creation or linking','Flow for the existing/non-existing user alternatives','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('ce49cba2-a7df-4994-99c4-5309c1f3fae3','direct grant','OpenID Connect Resource Owner Grant','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',1,1),('d19c076d-9f45-403e-b274-a1e5965ffabf','registration','registration flow','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',1,1),('d81aeef1-41ad-4758-b281-cd58b4354218','registration form','registration form','15e56e88-e77b-45e1-afa4-0d9a64309354','form-flow',0,1),('e232e4ee-e8a3-4317-8151-a6ad40673104','Account verification options','Method with which to verity the existing account','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',0,1),('e56a1cb0-b387-4e63-90e0-f67d6ce2116d','Browser - Conditional OTP','Flow to determine if the OTP is required for the authentication','15e56e88-e77b-45e1-afa4-0d9a64309354','basic-flow',0,1),('e9fa2f24-b105-4430-8f57-fbd639b3e1c4','direct grant','OpenID Connect Resource Owner Grant','f65da957-0a1a-47d4-9781-0118b7c15e3d','basic-flow',1,1),('ed269c54-83da-4673-941f-423fdcdecf89','clients','Base authentication for clients','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','client-flow',1,1),('ef977c39-bfdb-45eb-8a49-0b436bffb434','First broker login - Conditional OTP','Flow to determine if the OTP is required for the authentication','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',0,1),('fc2d16aa-f436-4b9b-9af7-08826e2b35c6','reset credentials','Reset credentials for a user if they forgot their password or something','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','basic-flow',1,1);
/*!40000 ALTER TABLE `AUTHENTICATION_FLOW` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATOR_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_AUTH_CONFIG_REALM` (`REALM_ID`),
  CONSTRAINT `FK_AUTH_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG`
--

LOCK TABLES `AUTHENTICATOR_CONFIG` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG` VALUES ('05c863dd-b6f5-4c8a-be7b-253d1aca8dd3','review profile config','15e56e88-e77b-45e1-afa4-0d9a64309354'),('2254e3dd-5b7c-4ea9-bd7b-5bc2b292fec8','review profile config','f65da957-0a1a-47d4-9781-0118b7c15e3d'),('2602a574-d569-4131-9744-b8035d96f1e8','review profile config','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf'),('c46fe620-5ec7-46dc-bc85-d37432ec6303','create unique user config','15e56e88-e77b-45e1-afa4-0d9a64309354'),('c81e00e4-bbc4-4e9e-8c1c-75a9d3a637ba','create unique user config','f65da957-0a1a-47d4-9781-0118b7c15e3d'),('ed42656d-2be1-4489-83d1-88cf4d5b3d7f','create unique user config','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `AUTHENTICATOR_CONFIG_ENTRY`
--

DROP TABLE IF EXISTS `AUTHENTICATOR_CONFIG_ENTRY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `AUTHENTICATOR_CONFIG_ENTRY` (
  `AUTHENTICATOR_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`AUTHENTICATOR_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AUTHENTICATOR_CONFIG_ENTRY`
--

LOCK TABLES `AUTHENTICATOR_CONFIG_ENTRY` WRITE;
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` DISABLE KEYS */;
INSERT INTO `AUTHENTICATOR_CONFIG_ENTRY` VALUES ('05c863dd-b6f5-4c8a-be7b-253d1aca8dd3','missing','update.profile.on.first.login'),('2254e3dd-5b7c-4ea9-bd7b-5bc2b292fec8','missing','update.profile.on.first.login'),('2602a574-d569-4131-9744-b8035d96f1e8','missing','update.profile.on.first.login'),('c46fe620-5ec7-46dc-bc85-d37432ec6303','false','require.password.update.after.registration'),('c81e00e4-bbc4-4e9e-8c1c-75a9d3a637ba','false','require.password.update.after.registration'),('ed42656d-2be1-4489-83d1-88cf4d5b3d7f','false','require.password.update.after.registration');
/*!40000 ALTER TABLE `AUTHENTICATOR_CONFIG_ENTRY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `BROKER_LINK`
--

DROP TABLE IF EXISTS `BROKER_LINK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `BROKER_LINK` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  `BROKER_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text,
  `USER_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BROKER_LINK`
--

LOCK TABLES `BROKER_LINK` WRITE;
/*!40000 ALTER TABLE `BROKER_LINK` DISABLE KEYS */;
/*!40000 ALTER TABLE `BROKER_LINK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT`
--

DROP TABLE IF EXISTS `CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT` (
  `ID` varchar(36) NOT NULL,
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `FULL_SCOPE_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int DEFAULT NULL,
  `PUBLIC_CLIENT` tinyint NOT NULL DEFAULT '0',
  `SECRET` varchar(255) DEFAULT NULL,
  `BASE_URL` varchar(255) DEFAULT NULL,
  `BEARER_ONLY` tinyint NOT NULL DEFAULT '0',
  `MANAGEMENT_URL` varchar(255) DEFAULT NULL,
  `SURROGATE_AUTH_REQUIRED` tinyint NOT NULL DEFAULT '0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  `NODE_REREG_TIMEOUT` int DEFAULT '0',
  `FRONTCHANNEL_LOGOUT` tinyint NOT NULL DEFAULT '0',
  `CONSENT_REQUIRED` tinyint NOT NULL DEFAULT '0',
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `SERVICE_ACCOUNTS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `CLIENT_AUTHENTICATOR_TYPE` varchar(255) DEFAULT NULL,
  `ROOT_URL` varchar(255) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REGISTRATION_TOKEN` varchar(255) DEFAULT NULL,
  `STANDARD_FLOW_ENABLED` tinyint NOT NULL DEFAULT '1',
  `IMPLICIT_FLOW_ENABLED` tinyint NOT NULL DEFAULT '0',
  `DIRECT_ACCESS_GRANTS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `ALWAYS_DISPLAY_IN_CONSOLE` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_B71CJLBENV945RB6GCON438AT` (`REALM_ID`,`CLIENT_ID`),
  KEY `IDX_CLIENT_ID` (`CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT`
--

LOCK TABLES `CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT` VALUES ('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,0,'realm-management',0,0,NULL,NULL,1,NULL,0,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','openid-connect',0,0,0,'${client_realm-management}',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,0,'account',0,1,NULL,'/realms/master/account/',0,NULL,0,'f65da957-0a1a-47d4-9781-0118b7c15e3d','openid-connect',0,0,0,'${client_account}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,0,'master-realm',0,0,NULL,NULL,1,NULL,0,'f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL,0,0,0,'master Realm',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6',1,0,'account-console',0,1,NULL,'/realms/nextjs/account/',0,NULL,0,'15e56e88-e77b-45e1-afa4-0d9a64309354','openid-connect',0,0,0,'${client_account-console}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('350c9c5c-ad9e-465c-a040-054e24aae52c',1,0,'broker',0,0,NULL,NULL,1,NULL,0,'f65da957-0a1a-47d4-9781-0118b7c15e3d','openid-connect',0,0,0,'${client_broker}',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('35a9d7e0-cc69-4605-a1ea-d36513839f09',1,0,'broker',0,0,NULL,NULL,1,NULL,0,'15e56e88-e77b-45e1-afa4-0d9a64309354','openid-connect',0,0,0,'${client_broker}',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('3d696010-2dc7-442c-9ec9-ecb743e382af',1,0,'realm-management',0,0,NULL,NULL,1,NULL,0,'15e56e88-e77b-45e1-afa4-0d9a64309354','openid-connect',0,0,0,'${client_realm-management}',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab',1,0,'broker',0,0,NULL,NULL,1,NULL,0,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','openid-connect',0,0,0,'${client_broker}',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('45eab072-6c16-4ce9-895e-b8b1567fbb1c',1,0,'security-admin-console',0,1,NULL,'/admin/nextjs/console/',0,NULL,0,'15e56e88-e77b-45e1-afa4-0d9a64309354','openid-connect',0,0,0,'${client_security-admin-console}',0,'client-secret','${authAdminUrl}',NULL,NULL,1,0,0,0),('565a59c8-7ca2-47eb-b2a4-23ca31d10617',1,0,'security-admin-console',0,1,NULL,'/admin/forum/console/',0,NULL,0,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','openid-connect',0,0,0,'${client_security-admin-console}',0,'client-secret','${authAdminUrl}',NULL,NULL,1,0,0,0),('56e41688-ad77-45be-9ea5-5feeebdd496e',1,0,'security-admin-console',0,1,NULL,'/admin/master/console/',0,NULL,0,'f65da957-0a1a-47d4-9781-0118b7c15e3d','openid-connect',0,0,0,'${client_security-admin-console}',0,'client-secret','${authAdminUrl}',NULL,NULL,1,0,0,0),('5c9f576c-0650-4a12-b3d0-b4556649baf4',1,1,'forum',0,1,NULL,'',0,'',0,'15e56e88-e77b-45e1-afa4-0d9a64309354','openid-connect',-1,1,0,'Forum Authentication',0,'client-secret','','',NULL,1,0,1,0),('899df6e9-d50a-4662-813c-fc672edcdbdf',1,0,'nextjs-realm',0,0,NULL,NULL,1,NULL,0,'f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL,0,0,0,'nextjs Realm',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('8f68b73b-954d-4245-9882-551d3823aa52',1,0,'forum-realm',0,0,NULL,NULL,1,NULL,0,'f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL,0,0,0,'forum Realm',0,'client-secret',NULL,NULL,NULL,1,0,0,0),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',1,1,'forum-authentication',0,0,'l2WiWQULnEFt9KrgySvFK03QtVf9K4DO','',0,'',0,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','openid-connect',-1,1,0,'Forum Authentication',0,'client-secret','','',NULL,1,0,1,0),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d',1,0,'account-console',0,1,NULL,'/realms/forum/account/',0,NULL,0,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','openid-connect',0,0,0,'${client_account-console}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('c50f75ca-b516-4ca8-ae8a-220102762e0b',1,0,'account',0,1,NULL,'/realms/forum/account/',0,NULL,0,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','openid-connect',0,0,0,'${client_account}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9',1,0,'admin-cli',0,1,NULL,NULL,0,NULL,0,'15e56e88-e77b-45e1-afa4-0d9a64309354','openid-connect',0,0,0,'${client_admin-cli}',0,'client-secret',NULL,NULL,NULL,0,0,1,0),('d994103a-c761-49e1-83cd-8dd421412620',1,0,'account-console',0,1,NULL,'/realms/master/account/',0,NULL,0,'f65da957-0a1a-47d4-9781-0118b7c15e3d','openid-connect',0,0,0,'${client_account-console}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('daeb2198-0b7a-4191-aa03-8710e42da7cc',1,0,'admin-cli',0,1,NULL,NULL,0,NULL,0,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','openid-connect',0,0,0,'${client_admin-cli}',0,'client-secret',NULL,NULL,NULL,0,0,1,0),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb',1,0,'account',0,1,NULL,'/realms/nextjs/account/',0,NULL,0,'15e56e88-e77b-45e1-afa4-0d9a64309354','openid-connect',0,0,0,'${client_account}',0,'client-secret','${authBaseUrl}',NULL,NULL,1,0,0,0),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f',1,0,'admin-cli',0,1,NULL,NULL,0,NULL,0,'f65da957-0a1a-47d4-9781-0118b7c15e3d','openid-connect',0,0,0,'${client_admin-cli}',0,'client-secret',NULL,NULL,NULL,0,0,1,0);
/*!40000 ALTER TABLE `CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_ATTRIBUTES` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  KEY `IDX_CLIENT_ATT_BY_NAME_VALUE` (`NAME`,`VALUE`(255)),
  CONSTRAINT `FK3C47C64BEACCA966` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_ATTRIBUTES`
--

LOCK TABLES `CLIENT_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_ATTRIBUTES` VALUES ('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','post.logout.redirect.uris','+'),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','pkce.code.challenge.method','S256'),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','post.logout.redirect.uris','+'),('35a9d7e0-cc69-4605-a1ea-d36513839f09','post.logout.redirect.uris','+'),('3d696010-2dc7-442c-9ec9-ecb743e382af','post.logout.redirect.uris','+'),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','pkce.code.challenge.method','S256'),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','post.logout.redirect.uris','+'),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','pkce.code.challenge.method','S256'),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','post.logout.redirect.uris','+'),('56e41688-ad77-45be-9ea5-5feeebdd496e','pkce.code.challenge.method','S256'),('56e41688-ad77-45be-9ea5-5feeebdd496e','post.logout.redirect.uris','+'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','backchannel.logout.revoke.offline.tokens','false'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','backchannel.logout.session.required','true'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','client.secret.creation.time','1728486114'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','display.on.consent.screen','false'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','oauth2.device.authorization.grant.enabled','false'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','oidc.ciba.grant.enabled','false'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','post.logout.redirect.uris','http://localhost:3000##http://localhost:8072'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','backchannel.logout.revoke.offline.tokens','false'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','backchannel.logout.session.required','true'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','client.secret.creation.time','1728833697'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','display.on.consent.screen','false'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','oauth2.device.authorization.grant.enabled','false'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','oidc.ciba.grant.enabled','false'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','post.logout.redirect.uris','http://localhost:3000##http://localhost:8072##http://gatewayserver:8072'),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','pkce.code.challenge.method','S256'),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','post.logout.redirect.uris','+'),('c50f75ca-b516-4ca8-ae8a-220102762e0b','post.logout.redirect.uris','+'),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','post.logout.redirect.uris','+'),('d994103a-c761-49e1-83cd-8dd421412620','pkce.code.challenge.method','S256'),('d994103a-c761-49e1-83cd-8dd421412620','post.logout.redirect.uris','+'),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','post.logout.redirect.uris','+');
/*!40000 ALTER TABLE `CLIENT_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_AUTH_FLOW_BINDINGS`
--

DROP TABLE IF EXISTS `CLIENT_AUTH_FLOW_BINDINGS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_AUTH_FLOW_BINDINGS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `FLOW_ID` varchar(36) DEFAULT NULL,
  `BINDING_NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`BINDING_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_AUTH_FLOW_BINDINGS`
--

LOCK TABLES `CLIENT_AUTH_FLOW_BINDINGS` WRITE;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_AUTH_FLOW_BINDINGS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_INITIAL_ACCESS`
--

DROP TABLE IF EXISTS `CLIENT_INITIAL_ACCESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_INITIAL_ACCESS` (
  `ID` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `EXPIRATION` int DEFAULT NULL,
  `COUNT` int DEFAULT NULL,
  `REMAINING_COUNT` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_INIT_ACC_REALM` (`REALM_ID`),
  CONSTRAINT `FK_CLIENT_INIT_ACC_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_INITIAL_ACCESS`
--

LOCK TABLES `CLIENT_INITIAL_ACCESS` WRITE;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_INITIAL_ACCESS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_NODE_REGISTRATIONS`
--

DROP TABLE IF EXISTS `CLIENT_NODE_REGISTRATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_NODE_REGISTRATIONS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` int DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`NAME`),
  CONSTRAINT `FK4129723BA992F594` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_NODE_REGISTRATIONS`
--

LOCK TABLES `CLIENT_NODE_REGISTRATIONS` WRITE;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_NODE_REGISTRATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `PROTOCOL` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_CLI_SCOPE` (`REALM_ID`,`NAME`),
  KEY `IDX_REALM_CLSCOPE` (`REALM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE`
--

LOCK TABLES `CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE` VALUES ('0009537e-c0b6-42d2-bc03-0f444c1c2774','role_list','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','SAML role list','saml'),('08cc9784-abae-4222-b79c-a29c1c80d32f','basic','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect scope for add all basic claims to the token','openid-connect'),('095e48a0-40c6-47c0-b438-2b3baa2acb37','address','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect built-in scope: address','openid-connect'),('1ae55ce0-138f-491e-8f40-d72f2cde4590','web-origins','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('226c15bb-33ef-4845-931d-27f03df6d065','address','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect built-in scope: address','openid-connect'),('26ad2e0f-2858-4708-9f0e-b36ef5957ab5','microprofile-jwt','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','Microprofile - JWT built-in scope','openid-connect'),('2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449','roles','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect scope for add user roles to the access token','openid-connect'),('34668ee5-d79f-4b1c-8116-44ace66dfdeb','phone','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect built-in scope: phone','openid-connect'),('3faf99cf-6f15-430a-bb1b-82cb86e2a5df','email','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect built-in scope: email','openid-connect'),('49009358-8fa1-4996-b77a-179509d8edfc','roles','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect scope for add user roles to the access token','openid-connect'),('4e6cc391-6c83-49b0-9d81-cba74e0a48ea','acr','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect scope for add acr (authentication context class reference) to the token','openid-connect'),('5106d93d-d258-4751-af11-3e885fe20567','offline_access','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect built-in scope: offline_access','openid-connect'),('6617ecae-8bd4-412f-8458-4f9f19cebd63','web-origins','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('66701909-f2ee-4c19-b5c9-b0375978d11d','profile','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect built-in scope: profile','openid-connect'),('68a14bef-30aa-4c9a-b2df-2d872039e915','web-origins','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect scope for add allowed web origins to the access token','openid-connect'),('87b0ace7-ebb0-4465-94ab-6f8f993a234a','phone','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect built-in scope: phone','openid-connect'),('91deb1f1-3467-4a17-9bdc-cc27a9cefbb5','email','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect built-in scope: email','openid-connect'),('947d8eb2-d905-4564-8524-245ec1c97604','acr','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect scope for add acr (authentication context class reference) to the token','openid-connect'),('a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2','microprofile-jwt','f65da957-0a1a-47d4-9781-0118b7c15e3d','Microprofile - JWT built-in scope','openid-connect'),('a47ac21b-c943-4367-b439-05d79ab4b602','basic','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect scope for add all basic claims to the token','openid-connect'),('a6fcc2db-5e24-4ebf-baa6-142bf1e18d26','address_info','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','Address Info','openid-connect'),('a927d35f-5ba7-43ef-aebd-99b06490882f','address','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect built-in scope: address','openid-connect'),('a9d8695b-ba1a-448c-aa44-0b2665231af0','roles','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect scope for add user roles to the access token','openid-connect'),('ae5179e3-c137-4211-9a53-4c4e72f2096a','acr','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect scope for add acr (authentication context class reference) to the token','openid-connect'),('b6084802-f03c-4500-a791-9d426d94b78f','offline_access','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect built-in scope: offline_access','openid-connect'),('ba5a618d-eb38-4b3d-89f0-930d25469cb7','email','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect built-in scope: email','openid-connect'),('c2c7d4fc-6967-49ad-ba95-1cc64bee1b99','microprofile-jwt','15e56e88-e77b-45e1-afa4-0d9a64309354','Microprofile - JWT built-in scope','openid-connect'),('d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce','profile','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect built-in scope: profile','openid-connect'),('dc4f4018-0584-4f37-964d-eca9cc2aa99d','basic','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect scope for add all basic claims to the token','openid-connect'),('ddc596ff-e80b-4989-b2b3-32335e07740c','offline_access','15e56e88-e77b-45e1-afa4-0d9a64309354','OpenID Connect built-in scope: offline_access','openid-connect'),('e52eb992-13f7-4886-a3b7-0e3df3a4e338','role_list','f65da957-0a1a-47d4-9781-0118b7c15e3d','SAML role list','saml'),('ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3','profile','f65da957-0a1a-47d4-9781-0118b7c15e3d','OpenID Connect built-in scope: profile','openid-connect'),('f0296697-946e-456e-b265-7c36b92726e7','phone','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','OpenID Connect built-in scope: phone','openid-connect'),('fdc515e3-b32a-422e-ab97-21e20521dc15','role_list','15e56e88-e77b-45e1-afa4-0d9a64309354','SAML role list','saml');
/*!40000 ALTER TABLE `CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ATTRIBUTES`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ATTRIBUTES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_ATTRIBUTES` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `VALUE` text,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`NAME`),
  KEY `IDX_CLSCOPE_ATTRS` (`SCOPE_ID`),
  CONSTRAINT `FK_CL_SCOPE_ATTR_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ATTRIBUTES`
--

LOCK TABLES `CLIENT_SCOPE_ATTRIBUTES` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ATTRIBUTES` VALUES ('0009537e-c0b6-42d2-bc03-0f444c1c2774','${samlRoleListScopeConsentText}','consent.screen.text'),('0009537e-c0b6-42d2-bc03-0f444c1c2774','true','display.on.consent.screen'),('08cc9784-abae-4222-b79c-a29c1c80d32f','false','display.on.consent.screen'),('08cc9784-abae-4222-b79c-a29c1c80d32f','false','include.in.token.scope'),('095e48a0-40c6-47c0-b438-2b3baa2acb37','${addressScopeConsentText}','consent.screen.text'),('095e48a0-40c6-47c0-b438-2b3baa2acb37','true','display.on.consent.screen'),('095e48a0-40c6-47c0-b438-2b3baa2acb37','true','include.in.token.scope'),('1ae55ce0-138f-491e-8f40-d72f2cde4590','','consent.screen.text'),('1ae55ce0-138f-491e-8f40-d72f2cde4590','false','display.on.consent.screen'),('1ae55ce0-138f-491e-8f40-d72f2cde4590','false','include.in.token.scope'),('226c15bb-33ef-4845-931d-27f03df6d065','${addressScopeConsentText}','consent.screen.text'),('226c15bb-33ef-4845-931d-27f03df6d065','true','display.on.consent.screen'),('226c15bb-33ef-4845-931d-27f03df6d065','true','include.in.token.scope'),('26ad2e0f-2858-4708-9f0e-b36ef5957ab5','false','display.on.consent.screen'),('26ad2e0f-2858-4708-9f0e-b36ef5957ab5','true','include.in.token.scope'),('2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449','${rolesScopeConsentText}','consent.screen.text'),('2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449','true','display.on.consent.screen'),('2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449','false','include.in.token.scope'),('34668ee5-d79f-4b1c-8116-44ace66dfdeb','${phoneScopeConsentText}','consent.screen.text'),('34668ee5-d79f-4b1c-8116-44ace66dfdeb','true','display.on.consent.screen'),('34668ee5-d79f-4b1c-8116-44ace66dfdeb','true','include.in.token.scope'),('3faf99cf-6f15-430a-bb1b-82cb86e2a5df','${emailScopeConsentText}','consent.screen.text'),('3faf99cf-6f15-430a-bb1b-82cb86e2a5df','true','display.on.consent.screen'),('3faf99cf-6f15-430a-bb1b-82cb86e2a5df','true','include.in.token.scope'),('49009358-8fa1-4996-b77a-179509d8edfc','${rolesScopeConsentText}','consent.screen.text'),('49009358-8fa1-4996-b77a-179509d8edfc','true','display.on.consent.screen'),('49009358-8fa1-4996-b77a-179509d8edfc','false','include.in.token.scope'),('4e6cc391-6c83-49b0-9d81-cba74e0a48ea','false','display.on.consent.screen'),('4e6cc391-6c83-49b0-9d81-cba74e0a48ea','false','include.in.token.scope'),('5106d93d-d258-4751-af11-3e885fe20567','${offlineAccessScopeConsentText}','consent.screen.text'),('5106d93d-d258-4751-af11-3e885fe20567','true','display.on.consent.screen'),('6617ecae-8bd4-412f-8458-4f9f19cebd63','','consent.screen.text'),('6617ecae-8bd4-412f-8458-4f9f19cebd63','false','display.on.consent.screen'),('6617ecae-8bd4-412f-8458-4f9f19cebd63','false','include.in.token.scope'),('66701909-f2ee-4c19-b5c9-b0375978d11d','${profileScopeConsentText}','consent.screen.text'),('66701909-f2ee-4c19-b5c9-b0375978d11d','true','display.on.consent.screen'),('66701909-f2ee-4c19-b5c9-b0375978d11d','true','include.in.token.scope'),('68a14bef-30aa-4c9a-b2df-2d872039e915','','consent.screen.text'),('68a14bef-30aa-4c9a-b2df-2d872039e915','false','display.on.consent.screen'),('68a14bef-30aa-4c9a-b2df-2d872039e915','false','include.in.token.scope'),('87b0ace7-ebb0-4465-94ab-6f8f993a234a','${phoneScopeConsentText}','consent.screen.text'),('87b0ace7-ebb0-4465-94ab-6f8f993a234a','true','display.on.consent.screen'),('87b0ace7-ebb0-4465-94ab-6f8f993a234a','true','include.in.token.scope'),('91deb1f1-3467-4a17-9bdc-cc27a9cefbb5','${emailScopeConsentText}','consent.screen.text'),('91deb1f1-3467-4a17-9bdc-cc27a9cefbb5','true','display.on.consent.screen'),('91deb1f1-3467-4a17-9bdc-cc27a9cefbb5','true','include.in.token.scope'),('947d8eb2-d905-4564-8524-245ec1c97604','false','display.on.consent.screen'),('947d8eb2-d905-4564-8524-245ec1c97604','false','include.in.token.scope'),('a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2','false','display.on.consent.screen'),('a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2','true','include.in.token.scope'),('a47ac21b-c943-4367-b439-05d79ab4b602','false','display.on.consent.screen'),('a47ac21b-c943-4367-b439-05d79ab4b602','false','include.in.token.scope'),('a6fcc2db-5e24-4ebf-baa6-142bf1e18d26','','consent.screen.text'),('a6fcc2db-5e24-4ebf-baa6-142bf1e18d26','true','display.on.consent.screen'),('a6fcc2db-5e24-4ebf-baa6-142bf1e18d26','','gui.order'),('a6fcc2db-5e24-4ebf-baa6-142bf1e18d26','false','include.in.token.scope'),('a927d35f-5ba7-43ef-aebd-99b06490882f','${addressScopeConsentText}','consent.screen.text'),('a927d35f-5ba7-43ef-aebd-99b06490882f','true','display.on.consent.screen'),('a927d35f-5ba7-43ef-aebd-99b06490882f','true','include.in.token.scope'),('a9d8695b-ba1a-448c-aa44-0b2665231af0','${rolesScopeConsentText}','consent.screen.text'),('a9d8695b-ba1a-448c-aa44-0b2665231af0','true','display.on.consent.screen'),('a9d8695b-ba1a-448c-aa44-0b2665231af0','false','include.in.token.scope'),('ae5179e3-c137-4211-9a53-4c4e72f2096a','false','display.on.consent.screen'),('ae5179e3-c137-4211-9a53-4c4e72f2096a','false','include.in.token.scope'),('b6084802-f03c-4500-a791-9d426d94b78f','${offlineAccessScopeConsentText}','consent.screen.text'),('b6084802-f03c-4500-a791-9d426d94b78f','true','display.on.consent.screen'),('ba5a618d-eb38-4b3d-89f0-930d25469cb7','${emailScopeConsentText}','consent.screen.text'),('ba5a618d-eb38-4b3d-89f0-930d25469cb7','true','display.on.consent.screen'),('ba5a618d-eb38-4b3d-89f0-930d25469cb7','true','include.in.token.scope'),('c2c7d4fc-6967-49ad-ba95-1cc64bee1b99','false','display.on.consent.screen'),('c2c7d4fc-6967-49ad-ba95-1cc64bee1b99','true','include.in.token.scope'),('d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce','${profileScopeConsentText}','consent.screen.text'),('d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce','true','display.on.consent.screen'),('d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce','true','include.in.token.scope'),('dc4f4018-0584-4f37-964d-eca9cc2aa99d','false','display.on.consent.screen'),('dc4f4018-0584-4f37-964d-eca9cc2aa99d','false','include.in.token.scope'),('ddc596ff-e80b-4989-b2b3-32335e07740c','${offlineAccessScopeConsentText}','consent.screen.text'),('ddc596ff-e80b-4989-b2b3-32335e07740c','true','display.on.consent.screen'),('e52eb992-13f7-4886-a3b7-0e3df3a4e338','${samlRoleListScopeConsentText}','consent.screen.text'),('e52eb992-13f7-4886-a3b7-0e3df3a4e338','true','display.on.consent.screen'),('ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3','${profileScopeConsentText}','consent.screen.text'),('ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3','true','display.on.consent.screen'),('ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3','true','include.in.token.scope'),('f0296697-946e-456e-b265-7c36b92726e7','${phoneScopeConsentText}','consent.screen.text'),('f0296697-946e-456e-b265-7c36b92726e7','true','display.on.consent.screen'),('f0296697-946e-456e-b265-7c36b92726e7','true','include.in.token.scope'),('fdc515e3-b32a-422e-ab97-21e20521dc15','${samlRoleListScopeConsentText}','consent.screen.text'),('fdc515e3-b32a-422e-ab97-21e20521dc15','true','display.on.consent.screen');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ATTRIBUTES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_CLIENT`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_CLIENT` (
  `CLIENT_ID` varchar(255) NOT NULL,
  `SCOPE_ID` varchar(255) NOT NULL,
  `DEFAULT_SCOPE` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`CLIENT_ID`,`SCOPE_ID`),
  KEY `IDX_CLSCOPE_CL` (`CLIENT_ID`),
  KEY `IDX_CL_CLSCOPE` (`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_CLIENT`
--

LOCK TABLES `CLIENT_SCOPE_CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_CLIENT` VALUES ('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','226c15bb-33ef-4845-931d-27f03df6d065',0),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','26ad2e0f-2858-4708-9f0e-b36ef5957ab5',0),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449',1),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','5106d93d-d258-4751-af11-3e885fe20567',0),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','68a14bef-30aa-4c9a-b2df-2d872039e915',1),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','91deb1f1-3467-4a17-9bdc-cc27a9cefbb5',1),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','ae5179e3-c137-4211-9a53-4c4e72f2096a',1),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce',1),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','dc4f4018-0584-4f37-964d-eca9cc2aa99d',1),('0234b9da-34e6-4f3f-a6d2-fe08ae1caf58','f0296697-946e-456e-b265-7c36b92726e7',0),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','08cc9784-abae-4222-b79c-a29c1c80d32f',1),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','095e48a0-40c6-47c0-b438-2b3baa2acb37',0),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','1ae55ce0-138f-491e-8f40-d72f2cde4590',1),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','3faf99cf-6f15-430a-bb1b-82cb86e2a5df',1),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','49009358-8fa1-4996-b77a-179509d8edfc',1),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','87b0ace7-ebb0-4465-94ab-6f8f993a234a',0),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','947d8eb2-d905-4564-8524-245ec1c97604',1),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2',0),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','b6084802-f03c-4500-a791-9d426d94b78f',0),('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3',1),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','08cc9784-abae-4222-b79c-a29c1c80d32f',1),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','095e48a0-40c6-47c0-b438-2b3baa2acb37',0),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','1ae55ce0-138f-491e-8f40-d72f2cde4590',1),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','3faf99cf-6f15-430a-bb1b-82cb86e2a5df',1),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','49009358-8fa1-4996-b77a-179509d8edfc',1),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','87b0ace7-ebb0-4465-94ab-6f8f993a234a',0),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','947d8eb2-d905-4564-8524-245ec1c97604',1),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2',0),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','b6084802-f03c-4500-a791-9d426d94b78f',0),('1fc8e766-9ec9-49e7-ad45-f76655d6508c','ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3',1),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','34668ee5-d79f-4b1c-8116-44ace66dfdeb',0),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','4e6cc391-6c83-49b0-9d81-cba74e0a48ea',1),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','6617ecae-8bd4-412f-8458-4f9f19cebd63',1),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','66701909-f2ee-4c19-b5c9-b0375978d11d',1),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','a47ac21b-c943-4367-b439-05d79ab4b602',1),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','a927d35f-5ba7-43ef-aebd-99b06490882f',0),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','a9d8695b-ba1a-448c-aa44-0b2665231af0',1),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','ba5a618d-eb38-4b3d-89f0-930d25469cb7',1),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','c2c7d4fc-6967-49ad-ba95-1cc64bee1b99',0),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','ddc596ff-e80b-4989-b2b3-32335e07740c',0),('350c9c5c-ad9e-465c-a040-054e24aae52c','08cc9784-abae-4222-b79c-a29c1c80d32f',1),('350c9c5c-ad9e-465c-a040-054e24aae52c','095e48a0-40c6-47c0-b438-2b3baa2acb37',0),('350c9c5c-ad9e-465c-a040-054e24aae52c','1ae55ce0-138f-491e-8f40-d72f2cde4590',1),('350c9c5c-ad9e-465c-a040-054e24aae52c','3faf99cf-6f15-430a-bb1b-82cb86e2a5df',1),('350c9c5c-ad9e-465c-a040-054e24aae52c','49009358-8fa1-4996-b77a-179509d8edfc',1),('350c9c5c-ad9e-465c-a040-054e24aae52c','87b0ace7-ebb0-4465-94ab-6f8f993a234a',0),('350c9c5c-ad9e-465c-a040-054e24aae52c','947d8eb2-d905-4564-8524-245ec1c97604',1),('350c9c5c-ad9e-465c-a040-054e24aae52c','a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2',0),('350c9c5c-ad9e-465c-a040-054e24aae52c','b6084802-f03c-4500-a791-9d426d94b78f',0),('350c9c5c-ad9e-465c-a040-054e24aae52c','ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3',1),('35a9d7e0-cc69-4605-a1ea-d36513839f09','34668ee5-d79f-4b1c-8116-44ace66dfdeb',0),('35a9d7e0-cc69-4605-a1ea-d36513839f09','4e6cc391-6c83-49b0-9d81-cba74e0a48ea',1),('35a9d7e0-cc69-4605-a1ea-d36513839f09','6617ecae-8bd4-412f-8458-4f9f19cebd63',1),('35a9d7e0-cc69-4605-a1ea-d36513839f09','66701909-f2ee-4c19-b5c9-b0375978d11d',1),('35a9d7e0-cc69-4605-a1ea-d36513839f09','a47ac21b-c943-4367-b439-05d79ab4b602',1),('35a9d7e0-cc69-4605-a1ea-d36513839f09','a927d35f-5ba7-43ef-aebd-99b06490882f',0),('35a9d7e0-cc69-4605-a1ea-d36513839f09','a9d8695b-ba1a-448c-aa44-0b2665231af0',1),('35a9d7e0-cc69-4605-a1ea-d36513839f09','ba5a618d-eb38-4b3d-89f0-930d25469cb7',1),('35a9d7e0-cc69-4605-a1ea-d36513839f09','c2c7d4fc-6967-49ad-ba95-1cc64bee1b99',0),('35a9d7e0-cc69-4605-a1ea-d36513839f09','ddc596ff-e80b-4989-b2b3-32335e07740c',0),('3d696010-2dc7-442c-9ec9-ecb743e382af','34668ee5-d79f-4b1c-8116-44ace66dfdeb',0),('3d696010-2dc7-442c-9ec9-ecb743e382af','4e6cc391-6c83-49b0-9d81-cba74e0a48ea',1),('3d696010-2dc7-442c-9ec9-ecb743e382af','6617ecae-8bd4-412f-8458-4f9f19cebd63',1),('3d696010-2dc7-442c-9ec9-ecb743e382af','66701909-f2ee-4c19-b5c9-b0375978d11d',1),('3d696010-2dc7-442c-9ec9-ecb743e382af','a47ac21b-c943-4367-b439-05d79ab4b602',1),('3d696010-2dc7-442c-9ec9-ecb743e382af','a927d35f-5ba7-43ef-aebd-99b06490882f',0),('3d696010-2dc7-442c-9ec9-ecb743e382af','a9d8695b-ba1a-448c-aa44-0b2665231af0',1),('3d696010-2dc7-442c-9ec9-ecb743e382af','ba5a618d-eb38-4b3d-89f0-930d25469cb7',1),('3d696010-2dc7-442c-9ec9-ecb743e382af','c2c7d4fc-6967-49ad-ba95-1cc64bee1b99',0),('3d696010-2dc7-442c-9ec9-ecb743e382af','ddc596ff-e80b-4989-b2b3-32335e07740c',0),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','226c15bb-33ef-4845-931d-27f03df6d065',0),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','26ad2e0f-2858-4708-9f0e-b36ef5957ab5',0),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449',1),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','5106d93d-d258-4751-af11-3e885fe20567',0),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','68a14bef-30aa-4c9a-b2df-2d872039e915',1),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','91deb1f1-3467-4a17-9bdc-cc27a9cefbb5',1),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','ae5179e3-c137-4211-9a53-4c4e72f2096a',1),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce',1),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','dc4f4018-0584-4f37-964d-eca9cc2aa99d',1),('3e7a4490-b72d-4b32-8e88-1a76cef6a8ab','f0296697-946e-456e-b265-7c36b92726e7',0),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','34668ee5-d79f-4b1c-8116-44ace66dfdeb',0),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','4e6cc391-6c83-49b0-9d81-cba74e0a48ea',1),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','6617ecae-8bd4-412f-8458-4f9f19cebd63',1),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','66701909-f2ee-4c19-b5c9-b0375978d11d',1),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','a47ac21b-c943-4367-b439-05d79ab4b602',1),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','a927d35f-5ba7-43ef-aebd-99b06490882f',0),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','a9d8695b-ba1a-448c-aa44-0b2665231af0',1),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','ba5a618d-eb38-4b3d-89f0-930d25469cb7',1),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','c2c7d4fc-6967-49ad-ba95-1cc64bee1b99',0),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','ddc596ff-e80b-4989-b2b3-32335e07740c',0),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','226c15bb-33ef-4845-931d-27f03df6d065',0),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','26ad2e0f-2858-4708-9f0e-b36ef5957ab5',0),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449',1),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','5106d93d-d258-4751-af11-3e885fe20567',0),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','68a14bef-30aa-4c9a-b2df-2d872039e915',1),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','91deb1f1-3467-4a17-9bdc-cc27a9cefbb5',1),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','ae5179e3-c137-4211-9a53-4c4e72f2096a',1),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce',1),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','dc4f4018-0584-4f37-964d-eca9cc2aa99d',1),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','f0296697-946e-456e-b265-7c36b92726e7',0),('56e41688-ad77-45be-9ea5-5feeebdd496e','08cc9784-abae-4222-b79c-a29c1c80d32f',1),('56e41688-ad77-45be-9ea5-5feeebdd496e','095e48a0-40c6-47c0-b438-2b3baa2acb37',0),('56e41688-ad77-45be-9ea5-5feeebdd496e','1ae55ce0-138f-491e-8f40-d72f2cde4590',1),('56e41688-ad77-45be-9ea5-5feeebdd496e','3faf99cf-6f15-430a-bb1b-82cb86e2a5df',1),('56e41688-ad77-45be-9ea5-5feeebdd496e','49009358-8fa1-4996-b77a-179509d8edfc',1),('56e41688-ad77-45be-9ea5-5feeebdd496e','87b0ace7-ebb0-4465-94ab-6f8f993a234a',0),('56e41688-ad77-45be-9ea5-5feeebdd496e','947d8eb2-d905-4564-8524-245ec1c97604',1),('56e41688-ad77-45be-9ea5-5feeebdd496e','a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2',0),('56e41688-ad77-45be-9ea5-5feeebdd496e','b6084802-f03c-4500-a791-9d426d94b78f',0),('56e41688-ad77-45be-9ea5-5feeebdd496e','ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3',1),('5c9f576c-0650-4a12-b3d0-b4556649baf4','34668ee5-d79f-4b1c-8116-44ace66dfdeb',0),('5c9f576c-0650-4a12-b3d0-b4556649baf4','4e6cc391-6c83-49b0-9d81-cba74e0a48ea',1),('5c9f576c-0650-4a12-b3d0-b4556649baf4','6617ecae-8bd4-412f-8458-4f9f19cebd63',1),('5c9f576c-0650-4a12-b3d0-b4556649baf4','66701909-f2ee-4c19-b5c9-b0375978d11d',1),('5c9f576c-0650-4a12-b3d0-b4556649baf4','a47ac21b-c943-4367-b439-05d79ab4b602',1),('5c9f576c-0650-4a12-b3d0-b4556649baf4','a927d35f-5ba7-43ef-aebd-99b06490882f',0),('5c9f576c-0650-4a12-b3d0-b4556649baf4','a9d8695b-ba1a-448c-aa44-0b2665231af0',1),('5c9f576c-0650-4a12-b3d0-b4556649baf4','ba5a618d-eb38-4b3d-89f0-930d25469cb7',1),('5c9f576c-0650-4a12-b3d0-b4556649baf4','c2c7d4fc-6967-49ad-ba95-1cc64bee1b99',0),('5c9f576c-0650-4a12-b3d0-b4556649baf4','ddc596ff-e80b-4989-b2b3-32335e07740c',0),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','26ad2e0f-2858-4708-9f0e-b36ef5957ab5',0),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449',1),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','5106d93d-d258-4751-af11-3e885fe20567',0),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','68a14bef-30aa-4c9a-b2df-2d872039e915',1),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','91deb1f1-3467-4a17-9bdc-cc27a9cefbb5',1),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','a6fcc2db-5e24-4ebf-baa6-142bf1e18d26',0),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','ae5179e3-c137-4211-9a53-4c4e72f2096a',1),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce',1),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','dc4f4018-0584-4f37-964d-eca9cc2aa99d',1),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','f0296697-946e-456e-b265-7c36b92726e7',0),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','226c15bb-33ef-4845-931d-27f03df6d065',0),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','26ad2e0f-2858-4708-9f0e-b36ef5957ab5',0),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449',1),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','5106d93d-d258-4751-af11-3e885fe20567',0),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','68a14bef-30aa-4c9a-b2df-2d872039e915',1),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','91deb1f1-3467-4a17-9bdc-cc27a9cefbb5',1),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','ae5179e3-c137-4211-9a53-4c4e72f2096a',1),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce',1),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','dc4f4018-0584-4f37-964d-eca9cc2aa99d',1),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','f0296697-946e-456e-b265-7c36b92726e7',0),('c50f75ca-b516-4ca8-ae8a-220102762e0b','226c15bb-33ef-4845-931d-27f03df6d065',0),('c50f75ca-b516-4ca8-ae8a-220102762e0b','26ad2e0f-2858-4708-9f0e-b36ef5957ab5',0),('c50f75ca-b516-4ca8-ae8a-220102762e0b','2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449',1),('c50f75ca-b516-4ca8-ae8a-220102762e0b','5106d93d-d258-4751-af11-3e885fe20567',0),('c50f75ca-b516-4ca8-ae8a-220102762e0b','68a14bef-30aa-4c9a-b2df-2d872039e915',1),('c50f75ca-b516-4ca8-ae8a-220102762e0b','91deb1f1-3467-4a17-9bdc-cc27a9cefbb5',1),('c50f75ca-b516-4ca8-ae8a-220102762e0b','ae5179e3-c137-4211-9a53-4c4e72f2096a',1),('c50f75ca-b516-4ca8-ae8a-220102762e0b','d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce',1),('c50f75ca-b516-4ca8-ae8a-220102762e0b','dc4f4018-0584-4f37-964d-eca9cc2aa99d',1),('c50f75ca-b516-4ca8-ae8a-220102762e0b','f0296697-946e-456e-b265-7c36b92726e7',0),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','34668ee5-d79f-4b1c-8116-44ace66dfdeb',0),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','4e6cc391-6c83-49b0-9d81-cba74e0a48ea',1),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','6617ecae-8bd4-412f-8458-4f9f19cebd63',1),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','66701909-f2ee-4c19-b5c9-b0375978d11d',1),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','a47ac21b-c943-4367-b439-05d79ab4b602',1),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','a927d35f-5ba7-43ef-aebd-99b06490882f',0),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','a9d8695b-ba1a-448c-aa44-0b2665231af0',1),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','ba5a618d-eb38-4b3d-89f0-930d25469cb7',1),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','c2c7d4fc-6967-49ad-ba95-1cc64bee1b99',0),('c7c8ec33-90b8-4573-bdcd-017c238ed8a9','ddc596ff-e80b-4989-b2b3-32335e07740c',0),('d994103a-c761-49e1-83cd-8dd421412620','08cc9784-abae-4222-b79c-a29c1c80d32f',1),('d994103a-c761-49e1-83cd-8dd421412620','095e48a0-40c6-47c0-b438-2b3baa2acb37',0),('d994103a-c761-49e1-83cd-8dd421412620','1ae55ce0-138f-491e-8f40-d72f2cde4590',1),('d994103a-c761-49e1-83cd-8dd421412620','3faf99cf-6f15-430a-bb1b-82cb86e2a5df',1),('d994103a-c761-49e1-83cd-8dd421412620','49009358-8fa1-4996-b77a-179509d8edfc',1),('d994103a-c761-49e1-83cd-8dd421412620','87b0ace7-ebb0-4465-94ab-6f8f993a234a',0),('d994103a-c761-49e1-83cd-8dd421412620','947d8eb2-d905-4564-8524-245ec1c97604',1),('d994103a-c761-49e1-83cd-8dd421412620','a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2',0),('d994103a-c761-49e1-83cd-8dd421412620','b6084802-f03c-4500-a791-9d426d94b78f',0),('d994103a-c761-49e1-83cd-8dd421412620','ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3',1),('daeb2198-0b7a-4191-aa03-8710e42da7cc','226c15bb-33ef-4845-931d-27f03df6d065',0),('daeb2198-0b7a-4191-aa03-8710e42da7cc','26ad2e0f-2858-4708-9f0e-b36ef5957ab5',0),('daeb2198-0b7a-4191-aa03-8710e42da7cc','2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449',1),('daeb2198-0b7a-4191-aa03-8710e42da7cc','5106d93d-d258-4751-af11-3e885fe20567',0),('daeb2198-0b7a-4191-aa03-8710e42da7cc','68a14bef-30aa-4c9a-b2df-2d872039e915',1),('daeb2198-0b7a-4191-aa03-8710e42da7cc','91deb1f1-3467-4a17-9bdc-cc27a9cefbb5',1),('daeb2198-0b7a-4191-aa03-8710e42da7cc','ae5179e3-c137-4211-9a53-4c4e72f2096a',1),('daeb2198-0b7a-4191-aa03-8710e42da7cc','d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce',1),('daeb2198-0b7a-4191-aa03-8710e42da7cc','dc4f4018-0584-4f37-964d-eca9cc2aa99d',1),('daeb2198-0b7a-4191-aa03-8710e42da7cc','f0296697-946e-456e-b265-7c36b92726e7',0),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','34668ee5-d79f-4b1c-8116-44ace66dfdeb',0),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','4e6cc391-6c83-49b0-9d81-cba74e0a48ea',1),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','6617ecae-8bd4-412f-8458-4f9f19cebd63',1),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','66701909-f2ee-4c19-b5c9-b0375978d11d',1),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','a47ac21b-c943-4367-b439-05d79ab4b602',1),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','a927d35f-5ba7-43ef-aebd-99b06490882f',0),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','a9d8695b-ba1a-448c-aa44-0b2665231af0',1),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','ba5a618d-eb38-4b3d-89f0-930d25469cb7',1),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','c2c7d4fc-6967-49ad-ba95-1cc64bee1b99',0),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','ddc596ff-e80b-4989-b2b3-32335e07740c',0),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','08cc9784-abae-4222-b79c-a29c1c80d32f',1),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','095e48a0-40c6-47c0-b438-2b3baa2acb37',0),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','1ae55ce0-138f-491e-8f40-d72f2cde4590',1),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','3faf99cf-6f15-430a-bb1b-82cb86e2a5df',1),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','49009358-8fa1-4996-b77a-179509d8edfc',1),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','87b0ace7-ebb0-4465-94ab-6f8f993a234a',0),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','947d8eb2-d905-4564-8524-245ec1c97604',1),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2',0),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','b6084802-f03c-4500-a791-9d426d94b78f',0),('f5c8eafa-c07e-4e6f-bcd5-6203dc25bb7f','ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3',1);
/*!40000 ALTER TABLE `CLIENT_SCOPE_CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SCOPE_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `CLIENT_SCOPE_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SCOPE_ROLE_MAPPING` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`ROLE_ID`),
  KEY `IDX_CLSCOPE_ROLE` (`SCOPE_ID`),
  KEY `IDX_ROLE_CLSCOPE` (`ROLE_ID`),
  CONSTRAINT `FK_CL_SCOPE_RM_SCOPE` FOREIGN KEY (`SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SCOPE_ROLE_MAPPING`
--

LOCK TABLES `CLIENT_SCOPE_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `CLIENT_SCOPE_ROLE_MAPPING` VALUES ('5106d93d-d258-4751-af11-3e885fe20567','36550a8c-4f99-463b-abca-59a23407df92'),('b6084802-f03c-4500-a791-9d426d94b78f','38671a58-41d1-41ff-8ae6-aa7f0dad6d96'),('ddc596ff-e80b-4989-b2b3-32335e07740c','4b897cd9-a6b0-4853-ae68-0a4c74f40bde');
/*!40000 ALTER TABLE `CLIENT_SCOPE_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION`
--

DROP TABLE IF EXISTS `CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `REDIRECT_URI` varchar(255) DEFAULT NULL,
  `STATE` varchar(255) DEFAULT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `SESSION_ID` varchar(36) DEFAULT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `AUTH_USER_ID` varchar(36) DEFAULT NULL,
  `CURRENT_ACTION` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_CLIENT_SESSION_SESSION` (`SESSION_ID`),
  CONSTRAINT `FK_B4AO2VCVAT6UKAU74WBWTFQO1` FOREIGN KEY (`SESSION_ID`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION`
--

LOCK TABLES `CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_AUTH_STATUS`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_AUTH_STATUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_AUTH_STATUS` (
  `AUTHENTICATOR` varchar(36) NOT NULL,
  `STATUS` int DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`AUTHENTICATOR`),
  CONSTRAINT `AUTH_STATUS_CONSTRAINT` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_AUTH_STATUS`
--

LOCK TABLES `CLIENT_SESSION_AUTH_STATUS` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_AUTH_STATUS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51C2736` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_NOTE`
--

LOCK TABLES `CLIENT_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_PROT_MAPPER`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_PROT_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_PROT_MAPPER` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`PROTOCOL_MAPPER_ID`),
  CONSTRAINT `FK_33A8SGQW18I532811V7O2DK89` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_PROT_MAPPER`
--

LOCK TABLES `CLIENT_SESSION_PROT_MAPPER` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_PROT_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_SESSION_ROLE`
--

DROP TABLE IF EXISTS `CLIENT_SESSION_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_SESSION_ROLE` (
  `ROLE_ID` varchar(255) NOT NULL,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`ROLE_ID`),
  CONSTRAINT `FK_11B7SGQW18I532811V7O2DV76` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_SESSION_ROLE`
--

LOCK TABLES `CLIENT_SESSION_ROLE` WRITE;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_SESSION_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CLIENT_USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `CLIENT_USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CLIENT_USER_SESSION_NOTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` text,
  `CLIENT_SESSION` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_SESSION`,`NAME`),
  CONSTRAINT `FK_CL_USR_SES_NOTE` FOREIGN KEY (`CLIENT_SESSION`) REFERENCES `CLIENT_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT_USER_SESSION_NOTE`
--

LOCK TABLES `CLIENT_USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `CLIENT_USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT`
--

DROP TABLE IF EXISTS `COMPONENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPONENT` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `PARENT_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_TYPE` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `SUB_TYPE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPONENT_REALM` (`REALM_ID`),
  KEY `IDX_COMPONENT_PROVIDER_TYPE` (`PROVIDER_TYPE`),
  CONSTRAINT `FK_COMPONENT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT`
--

LOCK TABLES `COMPONENT` WRITE;
/*!40000 ALTER TABLE `COMPONENT` DISABLE KEYS */;
INSERT INTO `COMPONENT` VALUES ('00d0ce3e-1ec3-4cc2-9744-07319696dfd3','Full Scope Disabled','15e56e88-e77b-45e1-afa4-0d9a64309354','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','anonymous'),('0aaf2346-7c25-4ae8-af93-229333eae426','Allowed Protocol Mapper Types','f65da957-0a1a-47d4-9781-0118b7c15e3d','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','authenticated'),('16187554-e37f-4517-a1a4-e254167c00a4','Allowed Client Scopes','15e56e88-e77b-45e1-afa4-0d9a64309354','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','anonymous'),('3113dbe7-3cea-4433-933b-ee2d6f805b8e','Trusted Hosts','f65da957-0a1a-47d4-9781-0118b7c15e3d','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','anonymous'),('4b968a85-d0b1-4c6b-a03a-d248e8a4287b','Allowed Client Scopes','f65da957-0a1a-47d4-9781-0118b7c15e3d','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','authenticated'),('4e9de20d-ff58-41f3-8075-62cbf3ac2ec0','Allowed Client Scopes','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','authenticated'),('4fad3947-2a57-49dc-b232-b697879135f9','Allowed Client Scopes','f65da957-0a1a-47d4-9781-0118b7c15e3d','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','anonymous'),('50984495-3a44-4c85-aac2-7a5e369c603e','rsa-enc-generated','15e56e88-e77b-45e1-afa4-0d9a64309354','rsa-enc-generated','org.keycloak.keys.KeyProvider','15e56e88-e77b-45e1-afa4-0d9a64309354',NULL),('56789481-819b-4e1c-953b-0e60f7e41122','Consent Required','15e56e88-e77b-45e1-afa4-0d9a64309354','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','anonymous'),('5a8da955-d9c5-4a06-98dc-e415895ba1b6','Trusted Hosts','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','anonymous'),('5cb1f80a-1f5e-438e-b9c6-17d1b61e441b','Consent Required','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','anonymous'),('5d8d20dc-6774-461e-8914-e3071e28d96e',NULL,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','declarative-user-profile','org.keycloak.userprofile.UserProfileProvider','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL),('5e172ebc-d846-452f-9e31-49208e8aedf1','aes-generated','15e56e88-e77b-45e1-afa4-0d9a64309354','aes-generated','org.keycloak.keys.KeyProvider','15e56e88-e77b-45e1-afa4-0d9a64309354',NULL),('6b252a7e-dc19-426a-a099-05bbb2b7141a','Allowed Protocol Mapper Types','15e56e88-e77b-45e1-afa4-0d9a64309354','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','authenticated'),('6d9d2486-6601-4dc1-bb21-121f05fcedea','rsa-enc-generated','f65da957-0a1a-47d4-9781-0118b7c15e3d','rsa-enc-generated','org.keycloak.keys.KeyProvider','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL),('7522456e-337c-44d7-9e51-bc1aada82c39','hmac-generated-hs512','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','hmac-generated','org.keycloak.keys.KeyProvider','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL),('7b397de7-1eb7-43a8-a771-b5c0807cfd06','Full Scope Disabled','f65da957-0a1a-47d4-9781-0118b7c15e3d','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','anonymous'),('9674ab41-cc3b-4fec-a89b-c275b81c845b','rsa-enc-generated','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','rsa-enc-generated','org.keycloak.keys.KeyProvider','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL),('96a2bfd3-eb04-48f0-838e-ae7fffc29138',NULL,'15e56e88-e77b-45e1-afa4-0d9a64309354','declarative-user-profile','org.keycloak.userprofile.UserProfileProvider','15e56e88-e77b-45e1-afa4-0d9a64309354',NULL),('99a67f23-8aeb-4657-a3ab-888c627f2ff6','hmac-generated-hs512','f65da957-0a1a-47d4-9781-0118b7c15e3d','hmac-generated','org.keycloak.keys.KeyProvider','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL),('9a572c2c-14d9-45a1-833f-be3bdb592a07','Allowed Protocol Mapper Types','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','authenticated'),('9afbdd72-45a2-448f-85ea-c380243d6b75','rsa-generated','f65da957-0a1a-47d4-9781-0118b7c15e3d','rsa-generated','org.keycloak.keys.KeyProvider','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL),('a0dc2ab0-632d-415e-bd76-91a0fb24fe32','rsa-generated','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','rsa-generated','org.keycloak.keys.KeyProvider','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL),('a13b4f21-9d7c-4532-9129-43a7f09d1674','Full Scope Disabled','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','scope','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','anonymous'),('a2dde161-f444-4ce6-8044-2919d7db3ce7','Allowed Protocol Mapper Types','f65da957-0a1a-47d4-9781-0118b7c15e3d','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','anonymous'),('a6993e51-bf4e-4d35-a71d-fa215d71dbf7','Max Clients Limit','f65da957-0a1a-47d4-9781-0118b7c15e3d','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','anonymous'),('a89be1d7-b063-4e0d-849e-30efec32370b',NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','declarative-user-profile','org.keycloak.userprofile.UserProfileProvider','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL),('af97d256-f942-497d-bb0d-3b84419fbffb','Allowed Protocol Mapper Types','15e56e88-e77b-45e1-afa4-0d9a64309354','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','anonymous'),('b191be4d-bae2-43af-b215-ef6e11d78349','Trusted Hosts','15e56e88-e77b-45e1-afa4-0d9a64309354','trusted-hosts','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','anonymous'),('bbf2a541-daf8-40fe-80bb-91144badbe52','hmac-generated-hs512','15e56e88-e77b-45e1-afa4-0d9a64309354','hmac-generated','org.keycloak.keys.KeyProvider','15e56e88-e77b-45e1-afa4-0d9a64309354',NULL),('c1dcd4b8-93f4-4de8-8018-6a3d46d22484','aes-generated','f65da957-0a1a-47d4-9781-0118b7c15e3d','aes-generated','org.keycloak.keys.KeyProvider','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL),('c7eb1878-80f3-4501-b4ef-868c8e812b3b','Allowed Client Scopes','15e56e88-e77b-45e1-afa4-0d9a64309354','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','authenticated'),('c8690340-8f7b-4c8e-a42f-05bac647f713','Max Clients Limit','15e56e88-e77b-45e1-afa4-0d9a64309354','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','anonymous'),('da85d8f5-d08a-423b-b02d-45e59d4c6e74','aes-generated','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','aes-generated','org.keycloak.keys.KeyProvider','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL),('dd784e0f-e52d-419e-b99a-d5c291de7321','Allowed Client Scopes','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','allowed-client-templates','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','anonymous'),('e8791e63-b0ee-4a67-a9dd-3635e322a6e2','Max Clients Limit','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','max-clients','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','anonymous'),('f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','Allowed Protocol Mapper Types','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','allowed-protocol-mappers','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','anonymous'),('fa3a8148-4bb9-4ab1-a476-ef3e2032b5f4','rsa-generated','15e56e88-e77b-45e1-afa4-0d9a64309354','rsa-generated','org.keycloak.keys.KeyProvider','15e56e88-e77b-45e1-afa4-0d9a64309354',NULL),('fcfc710a-a329-48d7-9d7b-a959fa0e3bff','Consent Required','f65da957-0a1a-47d4-9781-0118b7c15e3d','consent-required','org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','anonymous');
/*!40000 ALTER TABLE `COMPONENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPONENT_CONFIG`
--

DROP TABLE IF EXISTS `COMPONENT_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPONENT_CONFIG` (
  `ID` varchar(36) NOT NULL,
  `COMPONENT_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_COMPO_CONFIG_COMPO` (`COMPONENT_ID`),
  CONSTRAINT `FK_COMPONENT_CONFIG` FOREIGN KEY (`COMPONENT_ID`) REFERENCES `COMPONENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPONENT_CONFIG`
--

LOCK TABLES `COMPONENT_CONFIG` WRITE;
/*!40000 ALTER TABLE `COMPONENT_CONFIG` DISABLE KEYS */;
INSERT INTO `COMPONENT_CONFIG` VALUES ('013e6c70-4885-4cee-9be5-dc7569676ad3','3113dbe7-3cea-4433-933b-ee2d6f805b8e','client-uris-must-match','true'),('0460a3ed-8f9a-4cec-9cf2-cbfbebe62f3d','96a2bfd3-eb04-48f0-838e-ae7fffc29138','kc.user.profile.config','{\"attributes\":[{\"name\":\"username\",\"displayName\":\"${username}\",\"validations\":{\"length\":{\"min\":3,\"max\":255},\"username-prohibited-characters\":{},\"up-username-not-idn-homograph\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"email\",\"displayName\":\"${email}\",\"validations\":{\"email\":{},\"length\":{\"max\":255}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"firstName\",\"displayName\":\"${firstName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"lastName\",\"displayName\":\"${lastName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false}],\"groups\":[{\"name\":\"user-metadata\",\"displayHeader\":\"User metadata\",\"displayDescription\":\"Attributes, which refer to user metadata\"}],\"unmanagedAttributePolicy\":\"ENABLED\"}'),('06c04a77-659c-4b2c-9cfb-feff9261c379','da85d8f5-d08a-423b-b02d-45e59d4c6e74','priority','100'),('08869b48-19e1-46ba-96b6-773a8aa480a9','f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','allowed-protocol-mapper-types','oidc-full-name-mapper'),('094d595b-3a25-4666-8c22-36d3b636fd15','6b252a7e-dc19-426a-a099-05bbb2b7141a','allowed-protocol-mapper-types','oidc-full-name-mapper'),('0b70c574-f448-4f2d-a89c-75c05385b0a1','6b252a7e-dc19-426a-a099-05bbb2b7141a','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('0d8e6988-9d62-491d-94fb-b2ddca119a10','a2dde161-f444-4ce6-8044-2919d7db3ce7','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('12af7ca8-b143-44de-a029-f7b80426e875','9674ab41-cc3b-4fec-a89b-c275b81c845b','keyUse','ENC'),('15dedbb7-e9ad-446e-9ae0-1a107516cd43','da85d8f5-d08a-423b-b02d-45e59d4c6e74','secret','bCNMgxAJi8S2ywELl4LddA'),('17eccd38-3000-420c-8eff-d06bd620ad21','af97d256-f942-497d-bb0d-3b84419fbffb','allowed-protocol-mapper-types','saml-user-property-mapper'),('17fd4ef0-9354-4b07-ab92-fba2ae9ac888','a2dde161-f444-4ce6-8044-2919d7db3ce7','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('181dacc0-37da-47d5-b2ad-9f309ebfd60e','4e9de20d-ff58-41f3-8075-62cbf3ac2ec0','allow-default-scopes','true'),('1afb7cca-ee91-4a01-b871-323a60e57202','f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','allowed-protocol-mapper-types','saml-user-property-mapper'),('1b3f9e90-2035-46b7-b17d-b80babd3549b','5e172ebc-d846-452f-9e31-49208e8aedf1','priority','100'),('1f2b1854-1daf-4345-b94e-714fa689b39e','a2dde161-f444-4ce6-8044-2919d7db3ce7','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('20374f5e-bcec-46c1-bc43-c52ff5ae390e','7522456e-337c-44d7-9e51-bc1aada82c39','secret','3uK11meCG3I05P_rOG3y9OwmDmyqtngwzuhrIJFzVa8WdYe7je1_O76qk5K4c5gXoEhQj45zBnMuUM6raAmp-6-XKHhotfr1tXICO_DeFw8idJ1CO8QQXYx7LT0QUjxLkWsI_F8nPQKe26LwJKiAQzvNObts-n-obonuvab7CIo'),('225a370f-1c7b-4181-9bc5-e09f7d029ab6','af97d256-f942-497d-bb0d-3b84419fbffb','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('229762de-2877-42f4-8406-fa4a02fd7f7f','6b252a7e-dc19-426a-a099-05bbb2b7141a','allowed-protocol-mapper-types','saml-user-property-mapper'),('25ed58ee-93b0-4d85-828f-a57c1f77eb46','a89be1d7-b063-4e0d-849e-30efec32370b','kc.user.profile.config','{\"attributes\":[{\"name\":\"username\",\"displayName\":\"${username}\",\"validations\":{\"length\":{\"min\":3,\"max\":255},\"username-prohibited-characters\":{},\"up-username-not-idn-homograph\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"email\",\"displayName\":\"${email}\",\"validations\":{\"email\":{},\"length\":{\"max\":255}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"firstName\",\"displayName\":\"${firstName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"lastName\",\"displayName\":\"${lastName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false}],\"groups\":[{\"name\":\"user-metadata\",\"displayHeader\":\"User metadata\",\"displayDescription\":\"Attributes, which refer to user metadata\"}]}'),('29926044-9915-4d37-8d1e-327e72d60755','b191be4d-bae2-43af-b215-ef6e11d78349','client-uris-must-match','true'),('2e178950-ccfa-4cba-b5d3-c568e4b4a09c','5a8da955-d9c5-4a06-98dc-e415895ba1b6','host-sending-registration-request-must-match','true'),('2e5482d6-2ab9-4561-bf35-8b9eaf77ef43','50984495-3a44-4c85-aac2-7a5e369c603e','algorithm','RSA-OAEP'),('2f0a3e5f-1fe3-4bf6-b61b-dcbf39d31a4f','af97d256-f942-497d-bb0d-3b84419fbffb','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('2f6f4d5d-f2f4-4420-9d42-cc89a54e768b','f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('30adc4fa-09cf-48d9-b753-645fb01bab13','9674ab41-cc3b-4fec-a89b-c275b81c845b','certificate','MIICmTCCAYECBgGShoOHRjANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVmb3J1bTAeFw0yNDEwMTMxNTMxNTlaFw0zNDEwMTMxNTMzMzlaMBAxDjAMBgNVBAMMBWZvcnVtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqTTWW0/k7+241w6x/2ZJKxGb5c8zJEMqE7ft2XJrGdbj/WmhSgfKq5rJ7njptJK8sVECrDN84zi7Bw3zvkBHGR76vTD/mrEDgvjOdI2DRkb2Voyiti5iELeXKePn2ygUPtT+lTDXpUWTFokL2OdbB+OPNMMHTmmp6bMPgzlzb+GI8AdisHr2IPAHZTWHvaoZNl+khC5jjIRNU3A2l8uCuJO+zwnnYiTmBv6YstwAb+vuZUnsE8O1CdinvMzzzJHHEl8OSPElPvI3nA6J2wdf5PB8GoRf6Ocw2SW6J2kTgqj1gHf4FSczF5cT2eGu3W/iiWNPItqGxULNgxbZKDpAtQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAx0sqlleEpiClkzbb284hXdCeGrNA8U3jVDet5CWhUbLEXhDJhBrOctNLJc0D6CPIrunLDRONR4KSoFTyNf+nSzdQJYf1aibowC6oeYgoqK2l469rCBXAW6cN+O89jvQhn5uGDqDsDWHBtnqLVzSQG3fkGPfUew18NylGaeKEUEPJBG3g4wITkxWrsV+IlW6SQzuO+doFrI19VC4iIRfaOVWt8LR8soFcDUVvR2yYCAxU6FpGeKqPZeh4Pni/zU8ggq4jrV4Kr0/Cy0Gfm8a0/wcx4DjELmw8Im/jLMOy8IFcV4n6TjG9of3LdJ5md0ocRAqgpT1QebqyYyFX/iYS1'),('33bde888-423b-4854-af06-a81e2ecd669b','9674ab41-cc3b-4fec-a89b-c275b81c845b','priority','100'),('342af71a-81a2-4d6e-924a-1a20e9c5caa1','a2dde161-f444-4ce6-8044-2919d7db3ce7','allowed-protocol-mapper-types','saml-role-list-mapper'),('37604bec-cdd6-4499-8e90-9c3798581165','da85d8f5-d08a-423b-b02d-45e59d4c6e74','kid','580d01e5-d21a-4544-8bbc-e0068bc16065'),('391b3597-4685-4538-9ace-1f61461cebf8','4fad3947-2a57-49dc-b232-b697879135f9','allow-default-scopes','true'),('39767e47-eba8-4462-bc96-9cb3a383b505','c1dcd4b8-93f4-4de8-8018-6a3d46d22484','priority','100'),('3c7d5ee8-df76-4939-ac49-a45eb827119e','7522456e-337c-44d7-9e51-bc1aada82c39','kid','c0bf4e0b-2e74-4082-8aea-6cc406087432'),('3d56b818-9ae8-47c3-8d0f-6874b9a25722','9674ab41-cc3b-4fec-a89b-c275b81c845b','algorithm','RSA-OAEP'),('415ee75d-238a-4fb9-86b9-e4c7d2c33bcf','a2dde161-f444-4ce6-8044-2919d7db3ce7','allowed-protocol-mapper-types','saml-user-property-mapper'),('41dd4e28-d4cf-41ff-84a1-b76a32aaaeaf','dd784e0f-e52d-419e-b99a-d5c291de7321','allow-default-scopes','true'),('45d1f3d2-4ef2-45dc-bc00-0e49f8ec171d','9a572c2c-14d9-45a1-833f-be3bdb592a07','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('482808c9-4b78-4b54-b35a-3fdd031e624b','50984495-3a44-4c85-aac2-7a5e369c603e','priority','100'),('48de91d8-fa15-4ed4-86d3-4b845a597e18','0aaf2346-7c25-4ae8-af93-229333eae426','allowed-protocol-mapper-types','saml-user-property-mapper'),('49a9a693-6f1c-42ce-9aa2-bab2f5bf793f','a0dc2ab0-632d-415e-bd76-91a0fb24fe32','certificate','MIICmTCCAYECBgGShoOG7TANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVmb3J1bTAeFw0yNDEwMTMxNTMxNTlaFw0zNDEwMTMxNTMzMzlaMBAxDjAMBgNVBAMMBWZvcnVtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo/3BvMdgM8XgnSU8hKp7EMYfwT3NQU0tlIkuVtkGX/flyLZ+Q8dc1Z+dpWkpZLtyS2pHh1/ACQo/ynjh4DbqtPMj2+62hiPf8c6VXhZff07pXE15PGlhzhbqBDrEJBLiws2MKmN3pYyHwp5A/IOrLQNUr0gJjJ+VGwSNdJAhsl8RUmLzbZLThuSQcS0zWT1BpTo31K4WyRCl7Xvzy2xvfaiwpVlJjh4gYGU/1BzWe+P71z44sWldFM13M2jcS9/MsU9KMywvcOqlrpfBsGI272ddmEhUx6XhQ3yJP8unb9TNmHvhiRAw20a6dRjF57Del6A/nDRTv0O0crpyKhHRpQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQADMjPSUL8wrg/WcZBKMbIG3cU6VQg8jmYmG2WMh3eC8+7gx1fJtzp4DzUnYXy0FN86Np8dRzactxrtaU8/Nzn6YNqhXtq5MLIn2509bmH2s8ZHtpv1OG2J5g37a1LO2JxQYN5c6tR2p1qwvEEgCccczUivKVxcUJ1id0wDy/M8YE3XjwPnIrq9LBbzhBxmjw++N0cO13do7itvWcywuouF4EjVizIphHUboQ5SbyI0GxMvt/IWCTKd1OYINxZMFsurTEOLoHMTf1+3GpFfCKoM0IOdaziU+6JGYh6/txfH7f+zt1/WeNR6KqJtdG99AQmlCy4RRPNi9Hp14bCSgB83'),('4bc3ab2d-e3d6-4e3c-8739-0cf61e247c79','bbf2a541-daf8-40fe-80bb-91144badbe52','secret','QUaFqgs9-LK5CBnNbUNcHantxre9c_qyXRg-2DxkPd8_4QyNtFB8eaxx1eSyaL9ofT7u9qiUpSqkuMgKepySbTl0mzQ921KAwuPedOqBjnZDn_XBVd6FVTt4mMp7NqqHUN6CylE8U8Gb_RGVmvScBWadgRfqb6RGBXNqx6GY9xo'),('4cce805a-cd6b-4c3a-b776-547a84d1ef84','50984495-3a44-4c85-aac2-7a5e369c603e','privateKey','MIIEpQIBAAKCAQEAtQdGQkweg3gBz8CSX/XYkCmj370Qhc4mYQ1C7rPgBBXC/5PyNHaNxJYiHqwo43sW0YuMe2mCySnnvYgVEtOIhQyd+g4oQOSx3gWPacKZV0hMrqmMPqIntC3HJ9SPfPBaYZ1fQQDz+d6E0peb+byoXnTYroyHQ+TJb9RBg0P+bfazoi+0y8VEp+EM/OcQXs5yRP1Fk+BM0iZrfPeKWPE3RownZ1v4E564Eg41qIK6E6OskcA5aGwkk0uwlU/7s7m2/0J5ztVMKdguFlpW4R+24MDCvTZHZOxuoI/EXZuXlUci5t4DQ6a1hPj/682TD3uQqmklLiK3Tr1N93Ehvw6a3QIDAQABAoIBAAnjxC6FCA8N9FNhkDLr3xE+enRpA3O7577aQZ4sIis29niN9ZJw0506HSe90gdeHHNa2KmOrGrJqPO4G9FJJdEsTPPHPY27W2LnZ4aomfCkbi6wlo0pa1qIPF7BrwvCpGgRd+MOO/CaUSP2zQ+fWIy90hn0asNbxrbJoBadaqief7u2KQNWXI7HN0fDGH7r+6/ABNxcsZTcJHs3GYfwOeKabAxExDcx52kNLn98pkHqQEhXcMNNtLSqlhvABHCLGXSYzKwhw+agCFI2oW39LVT8r85L3Tp8/bwGDtYHK+TgOfUw7jI3DY04ZGq2IwNsznd2BVnEw4yGrtcmAEV71UUCgYEA6h+oE5ytLTeFMDWjYW6p2Fndm5EAF+UDPa6Nvkycl5RPzqX5skqQS0r48SGQrEVctaA9J6Kory+CfXi7loz8qQAOnkF5OUshovhNlGGeeSUcX9/haUmq2PPgM2ozPjIhboT45T5OafH1rZUmuivB78MbXZO3V+g2a4vxWg+S7LcCgYEAxfGORm/Apwc4RjKDkElRrOKvB2/OBoef7M860JLqBwEs7WHGh/N43xyzJuCrbbJnIFMJS2W6HXCcjQ+Ce3ep6oeoRFrTBsId/IZ+VHvvHcinc6UVUA4VjCnsixr4q0b3jNwZc+JQqUUIThawiyCDszyL87YCymTdozNbmA30CQsCgYEAmuuTplaYaUFByqLTl5dIoDbm4xfRvf32ZQxqErBTNiIXpSBC1+1rCcd0burM9pF3RV/g16dUg4emiywmxPpJ/fJhueqNMpI6kcJIY5Us7fDWk8JrP+ZVPPYzNxJhEhjN8nne0KKn9Ib9EH2PgMWPsP2j0An82hh4WjXh4LxJdoUCgYEAsX4uw75FlACHV3rIOkNkd5A0vohkx7opj2ErLgfuziUhsiJwsUuC4R2ND5l6Xr0QeA29UdyADRIDbwGvUSM2O9U070Y539+EoAHBmeQfwCdC8BHhkI1wiOS29O1UedEC/U4HjMAs7/u0vMDfwYGAVuI95GUbD31uuH6+7RPl9Y0CgYEAk5T5kIniLf3lABXdQYjIsD1BeveKBfRRt3vnbdnDhZTCse56NC4Dx5MIGuP+NRgiiEYXVByEk0Sgzy62y48DzQPgxtmjd3qhY+3xQGGchj7vrB/H5cGPHkCNM/YY68v0ZlKPCzcHfS5OgiJvVXEPx28KdC3P4SaDVHSQffuo/zs='),('4fbffb8d-1c24-4af1-b228-3dbb58e89d6d','a2dde161-f444-4ce6-8044-2919d7db3ce7','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('520d33e7-fde4-4e54-a0b0-a2a67815d804','16187554-e37f-4517-a1a4-e254167c00a4','allow-default-scopes','true'),('55793df3-de41-41c5-8557-0aec40873f60','af97d256-f942-497d-bb0d-3b84419fbffb','allowed-protocol-mapper-types','oidc-full-name-mapper'),('575717ff-54d0-4094-85d7-8905551d194e','0aaf2346-7c25-4ae8-af93-229333eae426','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('5c0c190a-4b5e-4101-9614-397f59b6b4a1','af97d256-f942-497d-bb0d-3b84419fbffb','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('5f281e14-f34c-4252-a50b-69fdb01398ee','0aaf2346-7c25-4ae8-af93-229333eae426','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('66c18929-282e-4b2d-9c2d-1933677c5ef9','9afbdd72-45a2-448f-85ea-c380243d6b75','keyUse','SIG'),('6761ab5f-d530-43e5-8275-577da8209d49','e8791e63-b0ee-4a67-a9dd-3635e322a6e2','max-clients','200'),('69a9416b-38ac-43c6-be0e-83e47a3a3c88','bbf2a541-daf8-40fe-80bb-91144badbe52','priority','100'),('7f8d4c1f-6acb-4637-97af-d269af0094b3','9a572c2c-14d9-45a1-833f-be3bdb592a07','allowed-protocol-mapper-types','oidc-full-name-mapper'),('85ee51a6-4af3-4590-ad2b-2f54b19f1a85','f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('882ad34f-990d-4b23-92ce-efa6f0fab9a6','a0dc2ab0-632d-415e-bd76-91a0fb24fe32','privateKey','MIIEogIBAAKCAQEAo/3BvMdgM8XgnSU8hKp7EMYfwT3NQU0tlIkuVtkGX/flyLZ+Q8dc1Z+dpWkpZLtyS2pHh1/ACQo/ynjh4DbqtPMj2+62hiPf8c6VXhZff07pXE15PGlhzhbqBDrEJBLiws2MKmN3pYyHwp5A/IOrLQNUr0gJjJ+VGwSNdJAhsl8RUmLzbZLThuSQcS0zWT1BpTo31K4WyRCl7Xvzy2xvfaiwpVlJjh4gYGU/1BzWe+P71z44sWldFM13M2jcS9/MsU9KMywvcOqlrpfBsGI272ddmEhUx6XhQ3yJP8unb9TNmHvhiRAw20a6dRjF57Del6A/nDRTv0O0crpyKhHRpQIDAQABAoIBAAd9lEdcrgK/Y5qZ9FE0/kkOW632djUo4s+ZkoHKCPYCOz83Qr4y0YU6dLd0/byJqVdTg+/lij5/dtl3Ow4ERCU+w+EMXs7yvYxsfLse9363qoYaTdLaF2sT9d16l7H0IOJ4BBJ9l536tMrJcrt2AjAcqlYVSsZfFa71vsZXvQpKJYohKt5s4FH7uHnlFd/IKlXzDW52xYYr94vSHnn6fVAB3YAXh30MuJYQWYzXcQf9jhuFtwSqB22utD1q2TqaQv262jPE2OGUTasLsCmRjFCSu0hVtKEow+Aupq5a6BqVXTyGTd0h/wh6Fj52zvgA1Gt1vIWrCrHwWIzAdXfKaIECgYEA5LHzFWEdym4DRANDVdVBRDUQRFvuhBMpT5FHHsQlxmBo4QrC+p6EDia2Fdjjme464bkZ5m74kU3YSkG9CL4tWNX7PhiYs2qnae0FCqWOzBjSTpYwl1PgDzWCcjSaVwG33RzJxSavswh4ctSXA4Xq/ZZCLgGDcV3XIz2ZCjGGlMECgYEAt5IjPinlumOpoSAr/a6RuRlUSv+i99dXmssRMC7Uz3g50vFX33SmoXzHcQfsfpRdy2QncHU8ENuvRU5ziujcWULcq0lOzNiJgjGScM8+fyN1pJMXL+4zn5plbXWy1ezwnQbJzx+kQDWnsScQ4WYF+1H/h4roRPFDTjICIVqaAeUCgYB1LB9pssp6rwcJT8quLYc1FSLyg0+fZ9ngpISV5NWd4EOcGdFwassqHPdqFif29DJC+H2mrPC6MfJBiZD668V8IJaLaDrEoj6IbSIKJG0XcRg/n3/h6N2BrV7aeM0jCwRTS66tTnby+cIMw5NkALc3mkbqH2hjKztRGPxSVrGngQKBgF7kpl8+HUkqt8dY8CSlFyNOGqriVwYzRU/5ZRs5Oj09cva+V6RlkrWr4RVm+TO90naPgWu6zqAQUBxNn6DRGwbxb00ECj4OOZcZtQ+nsjDazbeTacsXIYyBrajVzOqVHxStK6lsO+YNVnBXN3ys1q7CBou0nLj21soXQ86mHTKZAoGAR1tc3x1H/DodsSjbGFetpI5toHPHUpTNXT6UDrlU2KtMx1O+nS0iKBWmj4MvGPl1lMA9xAb5HvcHUVCdCcz6NabEJbehbfjGKjZOBpBFO6Svv31X9Di3uu7vayUA4YP97qvB2axMYVnvUf1diosRUYuqYmGs4688OtHAtsyPvGc='),('8a8199a6-9f09-4d9f-891b-5f4106f5939a','3113dbe7-3cea-4433-933b-ee2d6f805b8e','host-sending-registration-request-must-match','true'),('8d9127d9-a9eb-45de-9d0e-a429f9b50547','0aaf2346-7c25-4ae8-af93-229333eae426','allowed-protocol-mapper-types','oidc-address-mapper'),('8e746f9c-67cd-406d-a49f-b7490243f50d','50984495-3a44-4c85-aac2-7a5e369c603e','certificate','MIICmzCCAYMCBgGShnw5pjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZuZXh0anMwHhcNMjQxMDEzMTUyNDAxWhcNMzQxMDEzMTUyNTQxWjARMQ8wDQYDVQQDDAZuZXh0anMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC1B0ZCTB6DeAHPwJJf9diQKaPfvRCFziZhDULus+AEFcL/k/I0do3EliIerCjjexbRi4x7aYLJKee9iBUS04iFDJ36DihA5LHeBY9pwplXSEyuqYw+oie0Lccn1I988FphnV9BAPP53oTSl5v5vKhedNiujIdD5Mlv1EGDQ/5t9rOiL7TLxUSn4Qz85xBeznJE/UWT4EzSJmt894pY8TdGjCdnW/gTnrgSDjWogroTo6yRwDlobCSTS7CVT/uzubb/QnnO1Uwp2C4WWlbhH7bgwMK9Nkdk7G6gj8Rdm5eVRyLm3gNDprWE+P/rzZMPe5CqaSUuIrdOvU33cSG/DprdAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHP6BWa/kIFeXWLXIOL1GNhSB6iBaNCuO7CP3kXJjMbodKdWx4aexVLdmKH1BElxQbw9A9IaHH1bqclWkuNt7z39CFvNV28cbaHJP6w7lGzrzuzGLtfdvmd9L7ckqeghFjnkAPg7qxnP7pdR84ZRb1q8dSuHOaSzKksdWLlek50MFAjXh8noiPWZHItp3vwdrrxyVZ0HX7PsUQn9YKB1re9oQ7j2X7gVKszxv1f8wRhE9h36MQ8r3aghobzUnV9CB9G5ERhK9zDtdpvYcZodwvJr1Y+zhOEDxicuozNs2c4q99AREG545q747vkOTRi/S96ypyfIQ0MBR8UthtvB+pU='),('90ced101-86df-4874-9aa1-6384369744d3','6b252a7e-dc19-426a-a099-05bbb2b7141a','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('92cdb2d7-cf69-441f-9d57-c78ae75f4135','9afbdd72-45a2-448f-85ea-c380243d6b75','privateKey','MIIEowIBAAKCAQEAlFcnXq/1Xi91VkbBJSaz0oCYPdhTMzKmUPXBMDfOU7KeehTjfv/CcsNwnqTxsp8HObIj7K/FajUo+aSV0InqmBDIc7J/8HMAlS6fyOCtCtZvUUCr6ONrWwiOgR3FNwPMg5EUirfihXD6K/TwqMNRpBF/MhO7wNZZ4ox9h/tNFJklbJrzAfJVX+s9ns2+W5gn6KxymLbJ7XhieLAsSEEqRWNmhK9FCMV6YIN3Yhp78KKeph22+mDpqrYtNcV8ktOWV2D3qJxSSpmWtDfnCsjwAJtl3TSUhEW1QTIN9xgUTvD8lJrMKH7HSNkfSFMZFfXOn5vRY5BJso1FQGNprawjLQIDAQABAoIBABno6yh/xXTRB0atjxjlHK2c5nqO6WFc7G3hrv+0D6bQ4RtjwKSzGYygFHCxUMIpQsLSGbJCtVGqvWB1XfGR1VcAP3Lt76jY/XYRMbmNfMwSzli72gsQhfTdlr54q7TDRhqI4bSlD7zNEfVRkCN6Ei19HOFrTvUMu6B1d4uj2j/JiAhCyFcbok7FM9CprfwU1K9mvDTjYHgXSOdS6QipWOJG16WqgkUb+M3xyuwiJKvd3GHEeHBRtYEk9E44exwPQMbm7Fu4vfmcZZbHqZfNjTPDF+ErzoK1zfiPUm814MYPNSQ0Hf/UQ+CzgxZ+ENwHJHqF4w9SXUTr4d8AbbBxXIECgYEAxq9R8L7DUmgtE512duJVRay219bT/qXH6MbRj4Noq6R4K+QCAPuqO3uPhLIy1VWPonmHJd4mHpPD7d0rh/bvP3aIlx7hAePRJNPMy2Cl4ZPN3zEfFxYlozJ9Z3dblLaWlEqB057QKQ8iCp/q0p5FrLyM9BqUtkF5E04yPcH3gw0CgYEAvyHzDP/kILmgc6FdwBC8gQkMtxnUik1lzWOwfWychlSHnyofQZmGMSR0AcMXeCIeOoLCfCjzkXBNZI5HlOyHODbAdtfB2eMYho8v248j82cBBA+WjzKsxOqDprA2385ihWAv9NlWJyNjIZWHWm+59g+kwcAbHkVJcsJkxac/mKECgYAV9tm7IIudN5EMIxMuj1TX8AECmWg0NYWFET2nfOJ8XyE90OX7z9aA3ub9x2lhNiU70+2B3S4foTw+tn2SeVT3khYFhs9fEx1S0etI7HVKG7ndm6ORPMyKXxGH96TzKsA4wofZqive7iJYRFeEUyTmtK1saufXwiMtZC6fryq6nQKBgFavNAdSSwmYhq/KoLVKIeQ30X99hIqRHbmwG8xWpQq7baL/PJvI4DaLfN2LuKowdxs8UK50+Dqe/0q6yLY/K/iPxGxh4DZMq8PjTuY6Hij3L1vDIhqh9f99COZhhxGsDbzF6hoXM96eSwhhQ7j9cQ6q+6Mv2Fy7OduFVKTb/JjhAoGBAMM/mFof2zn+D4vSuiPmwIqNswqroOtJAmaTVBGcszHaYxrwBde36hiyCbu9ya0x79NqsISMalXZ8jQd5YLKYCmxWrWc+T0HEuqWp1EfCCDmIT/s0p8jl/pRSqu3yqBTEefySax+2KkCCEeQh1mUfd5pmFsJeie5CJnNYchK2t8v'),('96dac80f-f4fd-47e7-bfb8-e66086828ef4','bbf2a541-daf8-40fe-80bb-91144badbe52','algorithm','HS512'),('992275f6-a12f-4341-b7b3-c904e23ac3b9','6b252a7e-dc19-426a-a099-05bbb2b7141a','allowed-protocol-mapper-types','oidc-address-mapper'),('9a4387da-9726-4ce2-bc78-82838ba82bd8','fa3a8148-4bb9-4ab1-a476-ef3e2032b5f4','certificate','MIICmzCCAYMCBgGShnw46DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZuZXh0anMwHhcNMjQxMDEzMTUyNDAwWhcNMzQxMDEzMTUyNTQwWjARMQ8wDQYDVQQDDAZuZXh0anMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBqD0tw/vzflEU+9S8eMXNkBcOImxonZCFiuNDjwhW9cg50l7jxTi5rqRsARqOX1hFfggS0HPD43qQESZIJWpFS+BjYCOW9yGKJDubksHj/k3RGQxeqGZITP3nDD/dHY6Wx/vtAf/KtgrAYp15/OKxmz+FIJaY7qM2+sQUt86t3IbHQu3ai9rC02zXf/AW4SQ9BMBW+u0aHX9rv6pHW/kALFUr9CYT1ygeSTHW2VXJH/tlKigXzGr7RgTG1st40AjrSWeTy+SL2aLBOC+E7ZUXO/CiIAX7vdfLwBZ47BR4KYjiDhQSHipPC3m3JHW+G+LPH7EfUHnARALLRFhzXByVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADHQuMaIqHFh5LBRqgxIiIBaNNO2nMmc9XlkILhSsOfZEMDPd6cF/wgTdT3IcdvR+mIgPQJKNjOhzHPzTGrPW56ZMwe2v2yxsp6NddRlgA+Vy93YGDZ1YCpWHVEJnqOQ3z621yasdyhuKUHvc2Zy23wfoGfymAbzxRkssazAQVcoN0I5+eEjw/YrS9bbeWMmjpXKIxIs9Fs8PcTSeomDVj98bKMq0u1AD6PBW8SO6JT//7BbeK3ObYb6B9nBOWN7TGC9gRuX9+VYMzMlj8kU1TSwxdYWDBeTRdXOwwoHoxSdZFiqU5Bzcf3+g4tnhwSx4JjOsn1E5d40reHZceTNJlo='),('9acacc00-cb0a-4814-a1d5-40f21e38f9a9','9a572c2c-14d9-45a1-833f-be3bdb592a07','allowed-protocol-mapper-types','saml-role-list-mapper'),('9b22ef1e-bed5-4745-8d69-59443e94c1a7','9a572c2c-14d9-45a1-833f-be3bdb592a07','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('9ed756bf-6b3a-4d5f-8ec5-fbc0e1221cd2','9a572c2c-14d9-45a1-833f-be3bdb592a07','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('9efe7ccf-02d1-4a7f-b266-f226cb38974e','9674ab41-cc3b-4fec-a89b-c275b81c845b','privateKey','MIIEowIBAAKCAQEAqTTWW0/k7+241w6x/2ZJKxGb5c8zJEMqE7ft2XJrGdbj/WmhSgfKq5rJ7njptJK8sVECrDN84zi7Bw3zvkBHGR76vTD/mrEDgvjOdI2DRkb2Voyiti5iELeXKePn2ygUPtT+lTDXpUWTFokL2OdbB+OPNMMHTmmp6bMPgzlzb+GI8AdisHr2IPAHZTWHvaoZNl+khC5jjIRNU3A2l8uCuJO+zwnnYiTmBv6YstwAb+vuZUnsE8O1CdinvMzzzJHHEl8OSPElPvI3nA6J2wdf5PB8GoRf6Ocw2SW6J2kTgqj1gHf4FSczF5cT2eGu3W/iiWNPItqGxULNgxbZKDpAtQIDAQABAoIBACZ/oF8FylXhzXrW+95bqD2to74xutXfF0GFyY7+Vsp6B4U2xa0ZoT4Suaux5KDCez7P6w8BpwJu+7TS8piguNyJHS0zKxEIAf/IevbvZMU2a6GNHY9cddEOaI0uLuiBEbwrC6KnyoTu09TeiSzIlQByQPjVAAJSDcgfxuGJTo/PjjTEb0SP7c0IQIE75JMhxPJb5hnEOwE0llPKUXLLam9VTuCnynsWlxZXZAj+nXfZkLS0xysHwydTlCvqF6o2ASbJBOQ2vZ+d+RozAaOtyKY2KtRX4ppCeYlHy6xO0OEwDS5reUv1QeGqI2JY+fQFwcohhS+WnBJu1vj+11lrqfECgYEA7HJab+PcIHcWbkb4vMfphxDr3atZiL6NGxQVZ+jLuAaO9YpoQHqtdWFnWpq/mpgwGIPT6GxyFhPJgzcUhJVxMCryQUl1Llm0QlKRwV+oYJd5kHwqMxb6tRcb9CzFuj8JDeJSQRMz21J66eiyQiPlMaMB/kmeyg9cqkOgfiFPjEUCgYEAtzL8rEFJxcmt07jfpT7FfhZYyxJkEmRjTd1dTR4AuB6OdGonb/5dDcAWCDwtyAQAYPS8pqBfBZqy2bqfyKTRDSUztpxjCN5oS6qHcW5y8ggYWBd2QkuFVN8uC96ERVyfbjrs0ePVDV9p4AQSnZKfPYbl3cxJp09Bfu72r8PWAbECgYEAoJH/7KBXKwz0hKtZ3An/AyRwqTbmNMEC3nLDHq+vOSfrCcCWj8M/7MjbAWK53+ieMOfFjr+msmt5m8xZ+LfsCAQCRGf4ViPBEJE2PpYRqJb1jTNlDRD77OLmrumA1bxdD7q0lVDPFJBsvFC0TcpGqXDDt8aTOTE5gr8uTLmeZekCgYAi3GH2iWn3aDxauKheMoa0Sp5U7kf6s/2tmH0jqpzqbG4hOv4MMrQUZMQMhx8TG6fSy1+Guae7UkfMZNX5AVwCi1y+2B2EV4YzN90UObdH1UCEqtpHHUXe86U4fvxekpSIDlB4VEl7hPeJuFyufXMt6xiczz4Ix20oMWLh6Xs00QKBgEPRzIrYzPrv56MLYNZsTkQxDXgIN7rKiKMq2M7Cvedv9T5POKZeDkK6bqJWi7o9Grw1Rs3+Kcfvdw5qVD4wlaj/2vXrQSQ9oBItlJq4elrPPttNENCpwDY4Z4tIekWLalkXu0lPRqPyXft5nlT8PCngls7MpRtHq9l3zRipDDoH'),('a070dc3e-867e-4b11-a1b5-03795634c48e','a2dde161-f444-4ce6-8044-2919d7db3ce7','allowed-protocol-mapper-types','oidc-full-name-mapper'),('a0f7317a-d245-4405-bb91-b6cdcc902b8a','6d9d2486-6601-4dc1-bb21-121f05fcedea','algorithm','RSA-OAEP'),('a1aba278-d426-4e7f-9fa5-76e9243abf53','c8690340-8f7b-4c8e-a42f-05bac647f713','max-clients','200'),('a3581b4b-93be-4458-9380-36117dd68cff','99a67f23-8aeb-4657-a3ab-888c627f2ff6','kid','30f02a99-d0ed-46c5-adb1-4a5a5155b22d'),('a37bc0e3-359b-452c-b140-28b3010e5807','f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','allowed-protocol-mapper-types','saml-role-list-mapper'),('a461849f-aa32-4c05-bdc7-67af504f15cc','6b252a7e-dc19-426a-a099-05bbb2b7141a','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('a679e543-2c5a-4a2d-abf0-b5c7e74ac819','a6993e51-bf4e-4d35-a71d-fa215d71dbf7','max-clients','200'),('a8f8b35f-d7fd-4f4b-93ef-81258a5e81c7','0aaf2346-7c25-4ae8-af93-229333eae426','allowed-protocol-mapper-types','saml-role-list-mapper'),('abee0c33-f84c-493f-a664-86a04bf4f3e8','5d8d20dc-6774-461e-8914-e3071e28d96e','kc.user.profile.config','{\"attributes\":[{\"name\":\"username\",\"displayName\":\"${username}\",\"validations\":{\"length\":{\"min\":3,\"max\":255},\"username-prohibited-characters\":{},\"up-username-not-idn-homograph\":{}},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"email\",\"displayName\":\"${email}\",\"validations\":{\"email\":{},\"length\":{\"max\":255}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"firstName\",\"displayName\":\"${firstName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"lastName\",\"displayName\":\"${lastName}\",\"validations\":{\"length\":{\"max\":255},\"person-name-prohibited-characters\":{}},\"required\":{\"roles\":[\"user\"]},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"multivalued\":false},{\"name\":\"postalCode\",\"displayName\":\"Postal Code\",\"validations\":{},\"annotations\":{},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"group\":\"address\",\"multivalued\":false},{\"name\":\"city\",\"displayName\":\"City\",\"validations\":{\"length\":{\"min\":\"0\",\"max\":\"255\",\"trim-disabled\":\"false\"}},\"annotations\":{},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"group\":\"address\",\"multivalued\":false},{\"name\":\"country\",\"displayName\":\"Country\",\"validations\":{\"length\":{\"min\":\"0\",\"max\":\"255\"}},\"annotations\":{},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"group\":\"address\",\"multivalued\":false},{\"name\":\"birthday\",\"displayName\":\"Date of Birth\",\"validations\":{},\"annotations\":{},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"group\":\"user-metadata\",\"multivalued\":false},{\"name\":\"gender\",\"displayName\":\"Gender\",\"validations\":{},\"annotations\":{},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"group\":\"user-metadata\",\"multivalued\":false},{\"name\":\"picture\",\"displayName\":\"Profile Avatar URL\",\"validations\":{},\"annotations\":{},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"group\":\"user-metadata\",\"multivalued\":false},{\"name\":\"phoneNumber\",\"displayName\":\"Phone Number\",\"validations\":{},\"annotations\":{},\"permissions\":{\"view\":[\"admin\",\"user\"],\"edit\":[\"admin\",\"user\"]},\"group\":\"user-metadata\",\"multivalued\":false}],\"groups\":[{\"name\":\"user-metadata\",\"displayHeader\":\"User metadata\",\"displayDescription\":\"Attributes, which refer to user metadata\"},{\"name\":\"address\",\"displayHeader\":\"Address\",\"displayDescription\":\"\",\"annotations\":{}}],\"unmanagedAttributePolicy\":\"ENABLED\"}'),('ac74bcc8-18ba-49d0-b4ab-66058c2de984','6b252a7e-dc19-426a-a099-05bbb2b7141a','allowed-protocol-mapper-types','saml-role-list-mapper'),('acc35911-f279-4154-a4ee-d781f30680e8','a0dc2ab0-632d-415e-bd76-91a0fb24fe32','priority','100'),('ace830ab-5b14-4a47-ab10-75ed5bacd59d','fa3a8148-4bb9-4ab1-a476-ef3e2032b5f4','privateKey','MIIEowIBAAKCAQEAwag9LcP7835RFPvUvHjFzZAXDiJsaJ2QhYrjQ48IVvXIOdJe48U4ua6kbAEajl9YRX4IEtBzw+N6kBEmSCVqRUvgY2AjlvchiiQ7m5LB4/5N0RkMXqhmSEz95ww/3R2Olsf77QH/yrYKwGKdefzisZs/hSCWmO6jNvrEFLfOrdyGx0Lt2ovawtNs13/wFuEkPQTAVvrtGh1/a7+qR1v5ACxVK/QmE9coHkkx1tlVyR/7ZSooF8xq+0YExtbLeNAI60lnk8vki9miwTgvhO2VFzvwoiAF+73Xy8AWeOwUeCmI4g4UEh4qTwt5tyR1vhvizx+xH1B5wEQCy0RYc1wclQIDAQABAoIBAADxn9TqejOkrSuYAuTnkwasu45g32ZSKiLPy/Zz0FI2YwEOy7vxoTNRyZVdCWSdaz6LvOCch0UENifrC9MHXZXidmhwnk6Lvmw1E2of+L6Re94F0b9fh8Zu6wJuM8jKnvL6fg+YuZ842r27k2EdwdNMQjv+8FrBkF+qvfmQs+k1FAC2JYXxDks8FqiIenA/H8tLAuBnQOUBuJq/xzKisU6p0hQy7/uNX+j3nMjF8N68Zg5Hn6D2tHxYEW/FIjW4I5HH0jp3Z2/RnMU9PYHte4YfB/Dxc/2+zTY1gpsexYnfDgkdmyl2cHpJcIuRzcXqa0sKRfSDCIw1hUKXLrBOU6UCgYEA+Wdrnpq7zhYSQRT5z/fPvDyImcXV/fk3HeXO+nk+S1O1hn7wW3jDiyip7C90GXrbAzphzdkCsLKF4tSImlhQXX+1vyb1dVEh8oijixRmA41J18fisq/AfIz3R6H+BscZ8hUOM86W0zQSfr3ZOWzQTWfvt+9fBOot+v6Yn068It8CgYEAxsdjGh2oyEMKjK517OjkGsEThRWWFtrtb5myqC1wt7l9NF0ah3ho+NqzHvwhEKZajgz4g4++wUO/Hrtudc/S2J2eNUDGbWuRU3PaYSzTycscW+uOTHMfqRb2JHp1XEz0W8UiQT3Z2zxCIahz6zUI1s+IRuF9zcVPovJRGWziAwsCgYEArrKErdpRBvBq5O+edNBu0LnOLXhohrgUpXqd2tEmk3kVRBqSnmAfCND5BZnPxzFJTB+O9rO1sLO8GMEq1oJZ+MRGOJk/gmfMUajodblaI87KFL3My8FUIWpUo/aSi4jXYbzh7+QbveFRuzmceR8BYdcWEU84zaaDgrbnjV+HZR0CgYAkCf5Tu9DgDheZjf/fZhIFL8BEPrepiSPHOgyEJUjsZnrmxYKL0S7m/2++TGQKSr7cRknAQI2LKKc8AStzvKwzjdAjQ402RWxhvv125NO5IFQR7lEsVysEUx9pWbJxe5pKESG2xmn7L5+lzo7FtCXYHGROxY8zgXSAzIIbo/wOJQKBgBusNyhcEmX2T0OVHB4wLvurTNVhDPvufaCHIHvIDpA40iPW3N3++h76M84CvA405E5EBAnobkwN3GG8TGhlu+et2ScYGnpriPcz5Y/I+b8N9X2a5Ku5ZvybQQ9euptv0t/dRiXt/hgWyKEQXXkhoR0BArU0V5bZgqOWaeZ2KUlB'),('b34dd55f-6d07-46aa-aa5f-df61c5d3f1fd','99a67f23-8aeb-4657-a3ab-888c627f2ff6','secret','Ws2z4GUiiil3jKbn0-H1NPXD59INnFkpj2qB362TuqcjL1A5BvkHZPk4hqrV5jjY0lPvgNsI6G7T6qCMLdlw4DaKa8OEBuQhoeVETLCxJGSOGB3cTjBPhhx5f1gOFDJsTvw9xpVGORh-KCeikkMc4_yE9GpAwkZDOLhE3y1Y3UA'),('b5626cc4-2dae-4a3c-af8a-03408c9abd90','9afbdd72-45a2-448f-85ea-c380243d6b75','priority','100'),('b6ede4e7-931b-4ecf-8d5d-5b63cbbc914c','9a572c2c-14d9-45a1-833f-be3bdb592a07','allowed-protocol-mapper-types','oidc-address-mapper'),('b79098ed-c811-4d78-9477-a465fe73486f','a0dc2ab0-632d-415e-bd76-91a0fb24fe32','keyUse','SIG'),('ba44b01b-331d-4302-a54e-31c2daedfb54','7522456e-337c-44d7-9e51-bc1aada82c39','algorithm','HS512'),('bdad6634-201a-4402-aee9-5fd5befa09db','6d9d2486-6601-4dc1-bb21-121f05fcedea','privateKey','MIIEowIBAAKCAQEAxR/CjwcPoXhibu+bIZQ9GXlJL1l5/ywJmrm8T3nGQo3PLxSNDlswblM9jXDsIwxgs2DuCLEUrkOCN+Ra3WoEeFLTWuiA9IPGHrpOaqm80GKFfMqOuLz4th1uO+38JKxlUPLDVt0iJFvSRMiPepIoCrIV91EZPkbBNwGiiju9gEqBQBbV6qpyKxjTExb66rR4SpiN2FMS277ryzYXISy1/VBrfr6TWgZs1Uso2DYC5yOF2GiwEoSCkE3MchzEAOxlQREsQV8yylKhwhScEl1b/fPXthqmpxyUkuO1zJNciIY5P2x3L51EF1ACMcPUvn0hnKXqooJv6P0OgCCxDv+txwIDAQABAoIBABjxhA1+1RKsveE6xDReDSiIM+NgHPNV5Qs6ncz9ZEHaBDxOtetPTP67iBTkk+96v/vCyVa5OEbgIlNPO9OQ+EAqKYtzKJTdiHgtQVdMONOyO8ucLVjMCg6wBQRkALK6oSwP4/mTDCByAVaUfa9YB5AUPnpSkpv87l23ARR2gGwCCDIN6dSdO8N9Sn3FYtE2yV3i8AP09y6UTw+b61uPUCK35XO0WEW1AaErt6dayKsEz8tH/G0yVj+XJ6H6ZAPZ9mq42mPoR9MnJBLsT1iA1Vbz0yXKAqWH28fUrj/dSg22XKeaMF8A7ELGiybLc+WypbvPJorf7BGk0LP2gIbn9XECgYEA/qQEDby0lXiMc+OOXrkaA+Dt8Qf5smW06qGBQmMW8EWM5j1Yj22+6EWxjZxJd13WsFuqq8S+m9U4//NAxiQR5FkSyVe4aHByEMftf6IQVMPFw22LHE/ae2xqp9BhSKUlgxQqfvh09jZAro35dhmVSYxb7EGcFSEpmf/stIUgYLECgYEAxi0kybJLB/hpIQ7ODf+IukrBk+actdigwQXOHVbUb15FQxJ413P9p/FcHmNooF6Q/DyQqt9yGzZKqk7bENXM6ETREiNstitWKJ/LbdlE1ktqc+j+FTK33OlwWhlUoQFdj9MJNfHF6x1ZlOjAPQhHr/BnZEOmzNPuPVPU1HY5U/cCgYAHiqoIEh+zEZfvUr0Dty27Ea1aZycRDowWKuReJ/sk8Jpks0ptLQ3raS0CCa/vVhsmrABZCAGxMdZ3VigD9kuFXNH+npd6mGH4d0NkdVNQf1/bEuJ82yyYXTSndbd75FBBGpbLneYw6Jhv0wqhYc6XGA4c6DCMO6g0xGypSAwWcQKBgHhHLey8qY1M14GY2rbkQLfQZ2y8qqAzul1siIyGBqkRLjhnHbCmVW14r9BBxV6QBq8Qkz0iIL8jVG3JLmwpVxQhsEKx/WkTJFfDpFQnagAmBZYT8yIqhi0uAWKtvQ97JK4GB7EV7Gmmhpg6K3Lfc6L05cuUw8fNWOsf1iydFG5BAoGBANZsn4b69rcMwkZ2CC2uc2Xf2/hhyTTCFtJnKWJHitPXFYhZXGup5Tnep1v9PvOG2DLIjVvczt2sUgsu3UjHxbJb7k/5kGxv1oFAGOM66IBrcSusMEc7GVMrr2LDZg5FSifr765Gx3fPazc1TBRYghbyqow5O8S02m4nzPhT7Ket'),('bf73ba78-9975-460c-ab03-75ea0c29f3ad','fa3a8148-4bb9-4ab1-a476-ef3e2032b5f4','priority','100'),('bfc93b27-a1ea-449d-be7a-0596b6b50e53','af97d256-f942-497d-bb0d-3b84419fbffb','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('bfd27c76-a8e7-48d0-a3b2-ba15ff365550','f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','allowed-protocol-mapper-types','oidc-sha256-pairwise-sub-mapper'),('c06c3e45-a69b-4cd2-a52e-0f23fedca9ca','4b968a85-d0b1-4c6b-a03a-d248e8a4287b','allow-default-scopes','true'),('c090928b-fb4d-4909-8ccd-56191b9c5361','f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','allowed-protocol-mapper-types','oidc-address-mapper'),('c8123998-e85d-436c-9991-af99110eff54','a2dde161-f444-4ce6-8044-2919d7db3ce7','allowed-protocol-mapper-types','oidc-address-mapper'),('d06c658b-1f1d-47e0-b4ad-ae89d00a46b5','7522456e-337c-44d7-9e51-bc1aada82c39','priority','100'),('d104923c-3629-4e8b-b739-3ad811cb346a','0aaf2346-7c25-4ae8-af93-229333eae426','allowed-protocol-mapper-types','oidc-full-name-mapper'),('d1dd0831-d0b0-47dd-af06-45923aa69007','f94a6554-bd6e-4c64-b5f6-7f92f1c30c52','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('d1eb55f9-a7c1-40e5-a8e2-8dfa7da2fadf','6d9d2486-6601-4dc1-bb21-121f05fcedea','keyUse','ENC'),('d1f3db38-7ea4-4f3e-88a4-73ece64a2e48','99a67f23-8aeb-4657-a3ab-888c627f2ff6','algorithm','HS512'),('d3562b3a-7a9b-4b95-b1a6-f770214bba96','af97d256-f942-497d-bb0d-3b84419fbffb','allowed-protocol-mapper-types','oidc-address-mapper'),('dbe9d87c-ca3a-43b7-9be8-8ec8109bd360','af97d256-f942-497d-bb0d-3b84419fbffb','allowed-protocol-mapper-types','saml-role-list-mapper'),('dc10bfbc-4058-4659-8713-9c5a77e789a2','9a572c2c-14d9-45a1-833f-be3bdb592a07','allowed-protocol-mapper-types','saml-user-property-mapper'),('dd7b50cf-e8ce-4c77-9bf3-cc064236aee9','9afbdd72-45a2-448f-85ea-c380243d6b75','certificate','MIICmzCCAYMCBgGShnqc6DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMDEzMTUyMjE1WhcNMzQxMDEzMTUyMzU1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCUVyder/VeL3VWRsElJrPSgJg92FMzMqZQ9cEwN85Tsp56FON+/8Jyw3CepPGynwc5siPsr8VqNSj5pJXQieqYEMhzsn/wcwCVLp/I4K0K1m9RQKvo42tbCI6BHcU3A8yDkRSKt+KFcPor9PCow1GkEX8yE7vA1lnijH2H+00UmSVsmvMB8lVf6z2ezb5bmCforHKYtsnteGJ4sCxIQSpFY2aEr0UIxXpgg3diGnvwop6mHbb6YOmqti01xXyS05ZXYPeonFJKmZa0N+cKyPAAm2XdNJSERbVBMg33GBRO8PyUmswofsdI2R9IUxkV9c6fm9FjkEmyjUVAY2mtrCMtAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFUvFsXLJRZpJuf0aas0/imMHDTb6uvHQt3+c6TL4RXdH3oc4sNNlgIjvaRTpgWmx/lBN5BemgHuIQvKl+hqu02h0GTolE9jL2xA1MXPzXU9/zg5r7w600/W86zX/iEj2MNAV6AOQYNH2M1SoE2hXcQSuVzLL6Xu/S222R5NxhUzPyOoPfV72+7RY9zKJ+7IowENrahOA9ysHHKuw8HLz+/vZEGDcIGR4xP7tEp/zBBXPNfl9wIr5BUv8I9nl2cFRValD/vLOpZ2qvWyH7kEL0UVGPsJzQ/AbEB0/xKgDbEbLyrggmbifgyvPJTtqd5wePRm8PjaWcCNXXj3rJaSAXA='),('e2a65ce8-ebb5-472e-adce-f18aa8325d21','6b252a7e-dc19-426a-a099-05bbb2b7141a','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('e6b5054e-dc7e-4190-83c8-6b97d80259b1','5e172ebc-d846-452f-9e31-49208e8aedf1','kid','af1e0397-77f7-4f0b-829a-3bf0b4ea102a'),('e76d6321-e317-4dc8-ae81-b4f3af984c01','c1dcd4b8-93f4-4de8-8018-6a3d46d22484','secret','J9IUFdxpNbJWlyQMTdbViQ'),('e8d0a5ef-42a7-48b3-b0b1-d0d5fcfbcf55','b191be4d-bae2-43af-b215-ef6e11d78349','host-sending-registration-request-must-match','true'),('e933048d-86ba-4b67-8c30-7c3d4bdf1880','c1dcd4b8-93f4-4de8-8018-6a3d46d22484','kid','ee732c0b-87a7-474a-b07b-7e9da8e0a8ce'),('eb2d86fb-cd69-46d1-a408-3f0f875aae53','bbf2a541-daf8-40fe-80bb-91144badbe52','kid','e5c4541c-58d9-4207-8c91-3dd00b064921'),('eb5e1ae5-1243-4c10-9231-79c1fe112e90','5e172ebc-d846-452f-9e31-49208e8aedf1','secret','YYaQkWRE_32rYYJdzfCv6g'),('f05718f5-1e8d-42c3-80a8-343efa6efcab','0aaf2346-7c25-4ae8-af93-229333eae426','allowed-protocol-mapper-types','saml-user-attribute-mapper'),('f4663923-c24c-45fd-9d7d-dfa36acc1861','99a67f23-8aeb-4657-a3ab-888c627f2ff6','priority','100'),('f7863e67-1fee-4aa6-8bf2-3fa1247c9e35','9a572c2c-14d9-45a1-833f-be3bdb592a07','allowed-protocol-mapper-types','oidc-usermodel-attribute-mapper'),('f881b1d3-91cb-4f0a-b4f2-08d74c67d7cc','5a8da955-d9c5-4a06-98dc-e415895ba1b6','client-uris-must-match','true'),('f88688f5-f522-46c0-bfab-139ddf48fa68','0aaf2346-7c25-4ae8-af93-229333eae426','allowed-protocol-mapper-types','oidc-usermodel-property-mapper'),('fbef2a1e-86fc-4a11-a64c-efae62ebf172','6d9d2486-6601-4dc1-bb21-121f05fcedea','certificate','MIICmzCCAYMCBgGShnqdkDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQxMDEzMTUyMjE1WhcNMzQxMDEzMTUyMzU1WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDFH8KPBw+heGJu75shlD0ZeUkvWXn/LAmaubxPecZCjc8vFI0OWzBuUz2NcOwjDGCzYO4IsRSuQ4I35FrdagR4UtNa6ID0g8Yeuk5qqbzQYoV8yo64vPi2HW477fwkrGVQ8sNW3SIkW9JEyI96kigKshX3URk+RsE3AaKKO72ASoFAFtXqqnIrGNMTFvrqtHhKmI3YUxLbvuvLNhchLLX9UGt+vpNaBmzVSyjYNgLnI4XYaLAShIKQTcxyHMQA7GVBESxBXzLKUqHCFJwSXVv989e2GqanHJSS47XMk1yIhjk/bHcvnUQXUAIxw9S+fSGcpeqigm/o/Q6AILEO/63HAgMBAAEwDQYJKoZIhvcNAQELBQADggEBALEDPjkqlLPQXfWJ0Dn/mgwmd/SCDehZOAovFdCxy4/lPq/0uhDssNiwqqg0oIZUA7JKbI2oGYuDkm/5dhBR0nvefJ832wN6kL5+1e1OajgEXfnsc8I+atF41GS1ZMygeRHbFCySSnLXYqJkfjWgGIz58+6xRKDF5tC/TXrp7ES5kegz5mB8F0ZwGLKguzFxIESlZ9OTyaJZD04hmUsbWRkOLEQdV/AzwcmPCghIp8FAgEzSzmLG7ee0PSxBVqUBOEduvcQlOe/EtAVatQkJFdkZVqotH4fzxwZpZbEnp58sBCCrYx9rqUPhDanvz2l4E5Y6RS3Ppz0DRNeZebTOUVE='),('fd736714-969b-4788-a39b-1ee147db5944','c7eb1878-80f3-4501-b4ef-868c8e812b3b','allow-default-scopes','true'),('fea03009-3d76-4eaa-bec5-5f3e9622731e','6d9d2486-6601-4dc1-bb21-121f05fcedea','priority','100');
/*!40000 ALTER TABLE `COMPONENT_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMPOSITE_ROLE`
--

DROP TABLE IF EXISTS `COMPOSITE_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `COMPOSITE_ROLE` (
  `COMPOSITE` varchar(36) NOT NULL,
  `CHILD_ROLE` varchar(36) NOT NULL,
  PRIMARY KEY (`COMPOSITE`,`CHILD_ROLE`),
  KEY `IDX_COMPOSITE` (`COMPOSITE`),
  KEY `IDX_COMPOSITE_CHILD` (`CHILD_ROLE`),
  CONSTRAINT `FK_A63WVEKFTU8JO1PNJ81E7MCE2` FOREIGN KEY (`COMPOSITE`) REFERENCES `KEYCLOAK_ROLE` (`ID`),
  CONSTRAINT `FK_GR7THLLB9LU8Q4VQA4524JJY8` FOREIGN KEY (`CHILD_ROLE`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMPOSITE_ROLE`
--

LOCK TABLES `COMPOSITE_ROLE` WRITE;
/*!40000 ALTER TABLE `COMPOSITE_ROLE` DISABLE KEYS */;
INSERT INTO `COMPOSITE_ROLE` VALUES ('150a8f99-7152-452a-90e0-fbe3513b9017','3db23f3d-9fb5-46a2-b464-a724a54d5876'),('23cc61cf-547e-404c-9cff-b995591fe5bc','02a256d5-7f6b-4d92-84c0-6ec45fe82a60'),('4063d441-7d8f-4b2c-aec7-7626b61dd594','c996812f-1924-40aa-b53b-d426d5da98b1'),('4aba48c1-16f6-4fd0-b756-7a0de4ef5a57','42658cca-faa2-4555-991c-59ed8c836fc4'),('4aba48c1-16f6-4fd0-b756-7a0de4ef5a57','8645209c-81b6-470f-a1a1-c81a06ea0403'),('807057a1-7277-463d-a205-ae04b64b45c1','0189d22a-a266-40c4-bfd1-9633b2e7a385'),('807057a1-7277-463d-a205-ae04b64b45c1','095e2fe8-5c95-47c8-a00e-9c838e27158a'),('807057a1-7277-463d-a205-ae04b64b45c1','1483f8b3-ed2e-484d-9d69-0c12d5d243dd'),('807057a1-7277-463d-a205-ae04b64b45c1','150a8f99-7152-452a-90e0-fbe3513b9017'),('807057a1-7277-463d-a205-ae04b64b45c1','2425bcd2-e399-4d65-b59a-4c4d991ff9ab'),('807057a1-7277-463d-a205-ae04b64b45c1','2c9aacd1-a584-4307-90c2-4815cbf192a9'),('807057a1-7277-463d-a205-ae04b64b45c1','2fecdb8d-3468-4127-94b7-86496e9a0d82'),('807057a1-7277-463d-a205-ae04b64b45c1','3db23f3d-9fb5-46a2-b464-a724a54d5876'),('807057a1-7277-463d-a205-ae04b64b45c1','440823d2-a674-4acd-899c-5171cf943e0d'),('807057a1-7277-463d-a205-ae04b64b45c1','5b1a3184-aae1-4abe-9362-9e1afe799683'),('807057a1-7277-463d-a205-ae04b64b45c1','6e84f520-ca4c-4e14-bda0-fdd2c712bbab'),('807057a1-7277-463d-a205-ae04b64b45c1','83c859c0-2676-4e2b-858e-6fc1545e4800'),('807057a1-7277-463d-a205-ae04b64b45c1','84bc01dd-629b-4090-86e5-5d0b10c9877d'),('807057a1-7277-463d-a205-ae04b64b45c1','a4853fe7-e154-4896-98f5-eafe79a5280d'),('807057a1-7277-463d-a205-ae04b64b45c1','b64d2f95-10a3-40fc-9570-76a385a00f90'),('807057a1-7277-463d-a205-ae04b64b45c1','b6da413d-011a-4965-86d2-0479fddf5187'),('807057a1-7277-463d-a205-ae04b64b45c1','bd515cff-8940-4b64-a4ce-1ff34473a69e'),('807057a1-7277-463d-a205-ae04b64b45c1','e5db9456-f70a-4a46-a55c-d7d02cc26356'),('87c2becb-eb0d-4272-b78c-3c2aac9c0bb0','fc0c9472-8c2a-4bf0-b905-1869c53c7659'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','014a86c7-affa-4af1-872c-162c749766eb'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','01c1d07d-b2ee-4a72-894e-c0af54e9f546'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','05ab7526-624b-4280-8c33-01bc92d91b8c'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','10d932c4-fab2-45e8-af69-f9bd9c8f34b8'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','1383d857-16f6-4b23-a33c-4faf641f0d11'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','1fe4547f-02b7-4627-8fce-577578e107a0'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','2bede393-3463-4edb-8339-cfa293adfbec'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','2ef1b15e-bdb5-4bc1-bf64-882af80d2b9d'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','36999e33-c913-46b4-86e5-3b582284be0c'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','3ad05b7f-013f-4190-b345-7fa00cff2caf'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','3cf35d9a-ad2a-4274-95e3-607901f3debe'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','3ec301b3-7690-4be7-b78a-c4ac784f15bf'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','3f234307-1a91-49b5-bb56-77fc8fb39a94'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','42658cca-faa2-4555-991c-59ed8c836fc4'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','4aba48c1-16f6-4fd0-b756-7a0de4ef5a57'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','4dc3640a-58cc-47a0-b8c2-e789b33855ea'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','5639907f-e233-4a72-9682-befc1b25c86f'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','5a98df6b-33b5-4190-a825-40c7780a1cdb'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','6066858c-4b76-463a-99b8-4fbf1f2e005c'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','6481e013-17b1-450f-9ab1-f5e0dcf042d7'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','64df9e25-5d24-4027-baca-aebb78fde590'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','700825d6-4083-4276-8f10-8162318b2305'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','70c15f4f-78dc-43ca-950a-f07c219e077b'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','7b149774-efd3-477b-b9f5-4fa474ae319f'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','7b73b976-9f80-4b0d-b362-3fa7274f980f'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','82a090ea-efe4-4141-a859-f31a2c687997'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','8645209c-81b6-470f-a1a1-c81a06ea0403'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','87c2becb-eb0d-4272-b78c-3c2aac9c0bb0'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','888f0324-6c7f-4354-adf8-a89029384d9d'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','8d14bc18-5839-4940-8a48-ea12cae65d56'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','931e92ad-7859-4fcf-afc4-5edcfe9b2384'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','97ccf601-9d0c-42c5-85b7-cc660c268b58'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','986b1529-6e82-47bb-b98e-2d0c1d1e2af8'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','98763f74-f973-4360-a387-83bc348b5514'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','9c3a679a-2563-486c-aa42-fe8e07a80a19'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','aef6402f-979d-409e-9d08-21eec85c4435'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','b49341ad-3e39-4eb6-a238-6fddb4525557'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','b74b50ad-005f-4ed3-9c14-ea5161346a90'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','b7e599fd-ccf2-4f75-b7ce-a1e08b7c3cb3'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','c0e16b01-2108-419b-a825-fa8891082407'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','c137756b-cae9-462a-b02d-ba02e9b79228'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','d12c5222-7a5b-40ec-8f71-9b1db27b6488'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','d206f4f1-4605-4a70-bb6b-7a38cc7a38d9'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','d70f6e26-e9b5-424a-b7c5-76487bc11eaf'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','d751f761-0bd8-4eae-9487-9331afbfd6e4'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','dde77f95-83f6-4206-9262-e3e22044819a'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','de5c1bf9-a6e7-49ae-b5fc-5129ec1a9cc2'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','e23ba581-fb61-426c-8a6e-578accb4b53e'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','e4ad8c8e-24f5-4d5f-8625-aec603709762'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','e4fecb29-e432-41a7-b3e4-4f9e3785fc61'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','eec3c8fc-2436-498a-ae9a-ba018c445250'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','f80a66f3-93b8-47bb-8546-0652eef90a46'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','f8ee14a9-1356-4e2a-9197-082b8725ba59'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','fafbbc78-d8bc-43de-8b2c-80b7b17fa58c'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','fc0c9472-8c2a-4bf0-b905-1869c53c7659'),('986b1529-6e82-47bb-b98e-2d0c1d1e2af8','2ef1b15e-bdb5-4bc1-bf64-882af80d2b9d'),('986b1529-6e82-47bb-b98e-2d0c1d1e2af8','98763f74-f973-4360-a387-83bc348b5514'),('99108855-2637-4e7d-bfe3-6f492b037c6d','19afba7d-1ce9-4d1f-ad98-d6f9beefef00'),('99108855-2637-4e7d-bfe3-6f492b037c6d','cbd47c4a-9c2a-4217-9250-77e646b1b688'),('9a460e54-da96-4919-b647-d0d3397205f3','03585491-7c7f-4442-8b35-7f9103d8f867'),('9a460e54-da96-4919-b647-d0d3397205f3','4b897cd9-a6b0-4853-ae68-0a4c74f40bde'),('a2f57d4a-97ca-4fe5-813a-36e942bbd785','23cc61cf-547e-404c-9cff-b995591fe5bc'),('a2f57d4a-97ca-4fe5-813a-36e942bbd785','38671a58-41d1-41ff-8ae6-aa7f0dad6d96'),('a2f57d4a-97ca-4fe5-813a-36e942bbd785','8208b6a2-d173-4a7b-9e6e-cdd600204dbe'),('a2f57d4a-97ca-4fe5-813a-36e942bbd785','a48fee1e-1ad1-40b3-b2ab-1b51492bf697'),('b46a87dc-2cad-4bc7-9c66-2541714a8f65','221f6c73-5959-4467-82f5-025add48b94e'),('b49341ad-3e39-4eb6-a238-6fddb4525557','70c15f4f-78dc-43ca-950a-f07c219e077b'),('d70f6e26-e9b5-424a-b7c5-76487bc11eaf','b7e599fd-ccf2-4f75-b7ce-a1e08b7c3cb3'),('d70f6e26-e9b5-424a-b7c5-76487bc11eaf','e4ad8c8e-24f5-4d5f-8625-aec603709762'),('e23ba581-fb61-426c-8a6e-578accb4b53e','d751f761-0bd8-4eae-9487-9331afbfd6e4'),('e5db9456-f70a-4a46-a55c-d7d02cc26356','1483f8b3-ed2e-484d-9d69-0c12d5d243dd'),('e5db9456-f70a-4a46-a55c-d7d02cc26356','6e84f520-ca4c-4e14-bda0-fdd2c712bbab'),('f1280c1e-2251-4910-ae43-eadba9f9f379','36550a8c-4f99-463b-abca-59a23407df92'),('f1280c1e-2251-4910-ae43-eadba9f9f379','781f94d6-7b7c-4a17-9390-5945f0977b4e'),('f1280c1e-2251-4910-ae43-eadba9f9f379','7ab580eb-b26c-4110-9208-1b5bdf2ad40b'),('f1280c1e-2251-4910-ae43-eadba9f9f379','f4f8dcf0-61d8-48b2-982d-3190aa8b52bf'),('f17e72db-6b3d-4fdc-a322-c5b447ff9a13','6c26d85d-1aac-4541-9eaa-6a54bd630e48'),('f4f8dcf0-61d8-48b2-982d-3190aa8b52bf','78c49721-0172-4205-b80c-0f60b245eeaf'),('fc199046-925d-4680-a317-34be8a5b0a9e','19afba7d-1ce9-4d1f-ad98-d6f9beefef00'),('fc199046-925d-4680-a317-34be8a5b0a9e','221f6c73-5959-4467-82f5-025add48b94e'),('fc199046-925d-4680-a317-34be8a5b0a9e','304d958d-37ee-4c2a-ba28-e77e04639ab9'),('fc199046-925d-4680-a317-34be8a5b0a9e','5466bc49-f61e-4a59-9cdc-91e28451f724'),('fc199046-925d-4680-a317-34be8a5b0a9e','55d931ea-83eb-4631-9d4c-79322b08dc2f'),('fc199046-925d-4680-a317-34be8a5b0a9e','6dcdbafa-c197-4c3a-aba5-9f2e0fcb8ad6'),('fc199046-925d-4680-a317-34be8a5b0a9e','938d2359-8711-4110-a5d7-768c38a27965'),('fc199046-925d-4680-a317-34be8a5b0a9e','99108855-2637-4e7d-bfe3-6f492b037c6d'),('fc199046-925d-4680-a317-34be8a5b0a9e','9b3f0026-b933-4bb8-98c9-6440edcff1e7'),('fc199046-925d-4680-a317-34be8a5b0a9e','b46a87dc-2cad-4bc7-9c66-2541714a8f65'),('fc199046-925d-4680-a317-34be8a5b0a9e','b5b275ea-77e2-4354-8388-1ee633125fa0'),('fc199046-925d-4680-a317-34be8a5b0a9e','b71f4109-e25e-4453-bcd7-90157deaa0c9'),('fc199046-925d-4680-a317-34be8a5b0a9e','c51673ae-e96c-4d92-813c-8f21223b6ba0'),('fc199046-925d-4680-a317-34be8a5b0a9e','cbd47c4a-9c2a-4217-9250-77e646b1b688'),('fc199046-925d-4680-a317-34be8a5b0a9e','ccfc31db-84d9-4bb4-a315-1aaa6d1eb81d'),('fc199046-925d-4680-a317-34be8a5b0a9e','e4006004-2633-4b86-afec-1ceb2cc43da2'),('fc199046-925d-4680-a317-34be8a5b0a9e','eb61848a-4bce-406d-b73b-2d4489ee4be2'),('fc199046-925d-4680-a317-34be8a5b0a9e','fdf3016c-8019-4788-aafc-f79b285e3e32');
/*!40000 ALTER TABLE `COMPOSITE_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CREDENTIAL`
--

DROP TABLE IF EXISTS `CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext,
  `CREDENTIAL_DATA` longtext,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_CREDENTIAL` (`USER_ID`),
  CONSTRAINT `FK_PFYR0GLASQYL0DEI3KL69R6V0` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CREDENTIAL`
--

LOCK TABLES `CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `CREDENTIAL` DISABLE KEYS */;
INSERT INTO `CREDENTIAL` VALUES ('a136b78b-eec0-4504-b71e-7a840206445a',NULL,'password','600c7d3a-d660-451f-8fb9-edd45470b1d7',1731348134946,NULL,'{\"value\":\"dF3/lD0GSEFfiRrBNqaoIwCt9QUXbfUvJzGXVtnvFv0=\",\"salt\":\"ulLEWNj/nLOLA0fYLRbmbQ==\",\"additionalParameters\":{}}','{\"hashIterations\":5,\"algorithm\":\"argon2\",\"additionalParameters\":{\"hashLength\":[\"32\"],\"memory\":[\"7168\"],\"type\":[\"id\"],\"version\":[\"1.3\"],\"parallelism\":[\"1\"]}}',10),('d02177a4-79c7-4b0b-a7f1-9a8d2a23cc7e',NULL,'password','b07a6427-f410-43cf-b0d8-8c20cbe2cc43',1729367745913,NULL,'{\"value\":\"+EXF9DQuF939QeLkvPIlkszspixHEK1Y7/T+rKgZW54=\",\"salt\":\"/kEGxQ5i9NmOwlhbNqelrg==\",\"additionalParameters\":{}}','{\"hashIterations\":5,\"algorithm\":\"argon2\",\"additionalParameters\":{\"hashLength\":[\"32\"],\"memory\":[\"7168\"],\"type\":[\"id\"],\"version\":[\"1.3\"],\"parallelism\":[\"1\"]}}',10),('d800e41d-01bd-454f-aab3-c2cdcc50a5ba',NULL,'password','3092ccac-6a5c-4adf-ae2a-db29613ed31a',1728833036227,NULL,'{\"value\":\"clw6Lcjno0DG0vmdBfxluEz2TqI/E1AQCEOkuYMG28M=\",\"salt\":\"y6zxqtlgAm5DZThRkG4+Fw==\",\"additionalParameters\":{}}','{\"hashIterations\":5,\"algorithm\":\"argon2\",\"additionalParameters\":{\"hashLength\":[\"32\"],\"memory\":[\"7168\"],\"type\":[\"id\"],\"version\":[\"1.3\"],\"parallelism\":[\"1\"]}}',10),('f444587b-368f-4c3b-9665-18ed0764e75d',NULL,'password','2ae0321a-1c75-46d9-9cc5-1782aed402c1',1729096857696,'My password','{\"value\":\"7B+NKJxbTpeySFR27Ryh1CQwgtRJihn5+gADJuQTR5E=\",\"salt\":\"VrUVlcB7LyizfBOG6SmrWQ==\",\"additionalParameters\":{}}','{\"hashIterations\":5,\"algorithm\":\"argon2\",\"additionalParameters\":{\"hashLength\":[\"32\"],\"memory\":[\"7168\"],\"type\":[\"id\"],\"version\":[\"1.3\"],\"parallelism\":[\"1\"]}}',10);
/*!40000 ALTER TABLE `CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `databasechangelog`
--

DROP TABLE IF EXISTS `databasechangelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `databasechangelog` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `databasechangelog`
--

LOCK TABLES `databasechangelog` WRITE;
/*!40000 ALTER TABLE `databasechangelog` DISABLE KEYS */;
INSERT INTO `databasechangelog` VALUES ('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/jpa-changelog-1.0.0.Final.xml','2024-10-13 15:23:30',1,'EXECUTED','9:6f1016664e21e16d26517a4418f5e3df','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.0.0.Final-KEYCLOAK-5461','sthorger@redhat.com','META-INF/db2-jpa-changelog-1.0.0.Final.xml','2024-10-13 15:23:30',2,'MARK_RAN','9:828775b1596a07d1200ba1d49e5e3941','createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.1.0.Beta1','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Beta1.xml','2024-10-13 15:23:31',3,'EXECUTED','9:5f090e44a7d595883c1fb61f4b41fd38','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.1.0.Final','sthorger@redhat.com','META-INF/jpa-changelog-1.1.0.Final.xml','2024-10-13 15:23:31',4,'EXECUTED','9:c07e577387a3d2c04d1adc9aaad8730e','renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.2.0.Beta1','psilva@redhat.com','META-INF/jpa-changelog-1.2.0.Beta1.xml','2024-10-13 15:23:33',5,'EXECUTED','9:b68ce996c655922dbcd2fe6b6ae72686','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.2.0.Beta1','psilva@redhat.com','META-INF/db2-jpa-changelog-1.2.0.Beta1.xml','2024-10-13 15:23:33',6,'MARK_RAN','9:543b5c9989f024fe35c6f6c5a97de88e','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.2.0.RC1','bburke@redhat.com','META-INF/jpa-changelog-1.2.0.CR1.xml','2024-10-13 15:23:34',7,'EXECUTED','9:765afebbe21cf5bbca048e632df38336','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.2.0.RC1','bburke@redhat.com','META-INF/db2-jpa-changelog-1.2.0.CR1.xml','2024-10-13 15:23:34',8,'MARK_RAN','9:db4a145ba11a6fdaefb397f6dbf829a1','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.2.0.Final','keycloak','META-INF/jpa-changelog-1.2.0.Final.xml','2024-10-13 15:23:34',9,'EXECUTED','9:9d05c7be10cdb873f8bcb41bc3a8ab23','update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.3.0','bburke@redhat.com','META-INF/jpa-changelog-1.3.0.xml','2024-10-13 15:23:35',10,'EXECUTED','9:18593702353128d53111f9b1ff0b82b8','delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.4.0','bburke@redhat.com','META-INF/jpa-changelog-1.4.0.xml','2024-10-13 15:23:36',11,'EXECUTED','9:6122efe5f090e41a85c0f1c9e52cbb62','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.4.0','bburke@redhat.com','META-INF/db2-jpa-changelog-1.4.0.xml','2024-10-13 15:23:36',12,'MARK_RAN','9:e1ff28bf7568451453f844c5d54bb0b5','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.5.0','bburke@redhat.com','META-INF/jpa-changelog-1.5.0.xml','2024-10-13 15:23:36',13,'EXECUTED','9:7af32cd8957fbc069f796b61217483fd','delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.6.1_from15','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2024-10-13 15:23:36',14,'EXECUTED','9:6005e15e84714cd83226bf7879f54190','addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.6.1_from16-pre','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2024-10-13 15:23:36',15,'MARK_RAN','9:bf656f5a2b055d07f314431cae76f06c','delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.6.1_from16','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2024-10-13 15:23:36',16,'MARK_RAN','9:f8dadc9284440469dcf71e25ca6ab99b','dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.6.1','mposolda@redhat.com','META-INF/jpa-changelog-1.6.1.xml','2024-10-13 15:23:36',17,'EXECUTED','9:d41d8cd98f00b204e9800998ecf8427e','empty','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.7.0','bburke@redhat.com','META-INF/jpa-changelog-1.7.0.xml','2024-10-13 15:23:37',18,'EXECUTED','9:3368ff0be4c2855ee2dd9ca813b38d8e','createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.8.0','mposolda@redhat.com','META-INF/jpa-changelog-1.8.0.xml','2024-10-13 15:23:38',19,'EXECUTED','9:8ac2fb5dd030b24c0570a763ed75ed20','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.8.0-2','keycloak','META-INF/jpa-changelog-1.8.0.xml','2024-10-13 15:23:38',20,'EXECUTED','9:f91ddca9b19743db60e3057679810e6c','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.8.0','mposolda@redhat.com','META-INF/db2-jpa-changelog-1.8.0.xml','2024-10-13 15:23:38',21,'MARK_RAN','9:831e82914316dc8a57dc09d755f23c51','addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.8.0-2','keycloak','META-INF/db2-jpa-changelog-1.8.0.xml','2024-10-13 15:23:38',22,'MARK_RAN','9:f91ddca9b19743db60e3057679810e6c','dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.9.0','mposolda@redhat.com','META-INF/jpa-changelog-1.9.0.xml','2024-10-13 15:23:38',23,'EXECUTED','9:bc3d0f9e823a69dc21e23e94c7a94bb1','update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.9.1','keycloak','META-INF/jpa-changelog-1.9.1.xml','2024-10-13 15:23:38',24,'EXECUTED','9:c9999da42f543575ab790e76439a2679','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.9.1','keycloak','META-INF/db2-jpa-changelog-1.9.1.xml','2024-10-13 15:23:38',25,'MARK_RAN','9:0d6c65c6f58732d81569e77b10ba301d','modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM','',NULL,'4.25.1',NULL,NULL,'8833007157'),('1.9.2','keycloak','META-INF/jpa-changelog-1.9.2.xml','2024-10-13 15:23:39',26,'EXECUTED','9:fc576660fc016ae53d2d4778d84d86d0','createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-2.0.0','psilva@redhat.com','META-INF/jpa-changelog-authz-2.0.0.xml','2024-10-13 15:23:40',27,'EXECUTED','9:43ed6b0da89ff77206289e87eaa9c024','createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-2.5.1','psilva@redhat.com','META-INF/jpa-changelog-authz-2.5.1.xml','2024-10-13 15:23:40',28,'EXECUTED','9:44bae577f551b3738740281eceb4ea70','update tableName=RESOURCE_SERVER_POLICY','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.1.0-KEYCLOAK-5461','bburke@redhat.com','META-INF/jpa-changelog-2.1.0.xml','2024-10-13 15:23:41',29,'EXECUTED','9:bd88e1f833df0420b01e114533aee5e8','createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.2.0','bburke@redhat.com','META-INF/jpa-changelog-2.2.0.xml','2024-10-13 15:23:41',30,'EXECUTED','9:a7022af5267f019d020edfe316ef4371','addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.3.0','bburke@redhat.com','META-INF/jpa-changelog-2.3.0.xml','2024-10-13 15:23:41',31,'EXECUTED','9:fc155c394040654d6a79227e56f5e25a','createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.4.0','bburke@redhat.com','META-INF/jpa-changelog-2.4.0.xml','2024-10-13 15:23:41',32,'EXECUTED','9:eac4ffb2a14795e5dc7b426063e54d88','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.5.0','bburke@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2024-10-13 15:23:41',33,'EXECUTED','9:54937c05672568c4c64fc9524c1e9462','customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.5.0-unicode-oracle','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2024-10-13 15:23:41',34,'MARK_RAN','9:3a32bace77c84d7678d035a7f5a8084e','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.5.0-unicode-other-dbs','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2024-10-13 15:23:43',35,'EXECUTED','9:33d72168746f81f98ae3a1e8e0ca3554','modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.5.0-duplicate-email-support','slawomir@dabek.name','META-INF/jpa-changelog-2.5.0.xml','2024-10-13 15:23:43',36,'EXECUTED','9:61b6d3d7a4c0e0024b0c839da283da0c','addColumn tableName=REALM','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.5.0-unique-group-names','hmlnarik@redhat.com','META-INF/jpa-changelog-2.5.0.xml','2024-10-13 15:23:43',37,'EXECUTED','9:8dcac7bdf7378e7d823cdfddebf72fda','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.25.1',NULL,NULL,'8833007157'),('2.5.1','bburke@redhat.com','META-INF/jpa-changelog-2.5.1.xml','2024-10-13 15:23:43',38,'EXECUTED','9:a2b870802540cb3faa72098db5388af3','addColumn tableName=FED_USER_CONSENT','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.0.0','bburke@redhat.com','META-INF/jpa-changelog-3.0.0.xml','2024-10-13 15:23:43',39,'EXECUTED','9:132a67499ba24bcc54fb5cbdcfe7e4c0','addColumn tableName=IDENTITY_PROVIDER','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.2.0-fix','keycloak','META-INF/jpa-changelog-3.2.0.xml','2024-10-13 15:23:43',40,'MARK_RAN','9:938f894c032f5430f2b0fafb1a243462','addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.2.0-fix-with-keycloak-5416','keycloak','META-INF/jpa-changelog-3.2.0.xml','2024-10-13 15:23:43',41,'MARK_RAN','9:845c332ff1874dc5d35974b0babf3006','dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.2.0-fix-offline-sessions','hmlnarik','META-INF/jpa-changelog-3.2.0.xml','2024-10-13 15:23:43',42,'EXECUTED','9:fc86359c079781adc577c5a217e4d04c','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.2.0-fixed','keycloak','META-INF/jpa-changelog-3.2.0.xml','2024-10-13 15:23:44',43,'EXECUTED','9:59a64800e3c0d09b825f8a3b444fa8f4','addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.3.0','keycloak','META-INF/jpa-changelog-3.3.0.xml','2024-10-13 15:23:44',44,'EXECUTED','9:d48d6da5c6ccf667807f633fe489ce88','addColumn tableName=USER_ENTITY','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-3.4.0.CR1-resource-server-pk-change-part1','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-10-13 15:23:44',45,'EXECUTED','9:dde36f7973e80d71fceee683bc5d2951','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-10-13 15:23:44',46,'EXECUTED','9:b855e9b0a406b34fa323235a0cf4f640','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-10-13 15:23:44',47,'MARK_RAN','9:51abbacd7b416c50c4421a8cabf7927e','dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-10-13 15:23:45',48,'EXECUTED','9:bdc99e567b3398bac83263d375aad143','addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authn-3.4.0.CR1-refresh-token-max-reuse','glavoie@gmail.com','META-INF/jpa-changelog-authz-3.4.0.CR1.xml','2024-10-13 15:23:45',49,'EXECUTED','9:d198654156881c46bfba39abd7769e69','addColumn tableName=REALM','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.4.0','keycloak','META-INF/jpa-changelog-3.4.0.xml','2024-10-13 15:23:46',50,'EXECUTED','9:cfdd8736332ccdd72c5256ccb42335db','addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.4.0-KEYCLOAK-5230','hmlnarik@redhat.com','META-INF/jpa-changelog-3.4.0.xml','2024-10-13 15:23:46',51,'EXECUTED','9:7c84de3d9bd84d7f077607c1a4dcb714','createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.4.1','psilva@redhat.com','META-INF/jpa-changelog-3.4.1.xml','2024-10-13 15:23:46',52,'EXECUTED','9:5a6bb36cbefb6a9d6928452c0852af2d','modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.4.2','keycloak','META-INF/jpa-changelog-3.4.2.xml','2024-10-13 15:23:46',53,'EXECUTED','9:8f23e334dbc59f82e0a328373ca6ced0','update tableName=REALM','',NULL,'4.25.1',NULL,NULL,'8833007157'),('3.4.2-KEYCLOAK-5172','mkanis@redhat.com','META-INF/jpa-changelog-3.4.2.xml','2024-10-13 15:23:46',54,'EXECUTED','9:9156214268f09d970cdf0e1564d866af','update tableName=CLIENT','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.0.0-KEYCLOAK-6335','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2024-10-13 15:23:46',55,'EXECUTED','9:db806613b1ed154826c02610b7dbdf74','createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.0.0-CLEANUP-UNUSED-TABLE','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2024-10-13 15:23:46',56,'EXECUTED','9:229a041fb72d5beac76bb94a5fa709de','dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.0.0-KEYCLOAK-6228','bburke@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2024-10-13 15:23:46',57,'EXECUTED','9:079899dade9c1e683f26b2aa9ca6ff04','dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.0.0-KEYCLOAK-5579-fixed','mposolda@redhat.com','META-INF/jpa-changelog-4.0.0.xml','2024-10-13 15:23:48',58,'EXECUTED','9:139b79bcbbfe903bb1c2d2a4dbf001d9','dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-4.0.0.CR1','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.CR1.xml','2024-10-13 15:23:49',59,'EXECUTED','9:b55738ad889860c625ba2bf483495a04','createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-4.0.0.Beta3','psilva@redhat.com','META-INF/jpa-changelog-authz-4.0.0.Beta3.xml','2024-10-13 15:23:49',60,'EXECUTED','9:e0057eac39aa8fc8e09ac6cfa4ae15fe','addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-4.2.0.Final','mhajas@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2024-10-13 15:23:49',61,'EXECUTED','9:42a33806f3a0443fe0e7feeec821326c','createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-4.2.0.Final-KEYCLOAK-9944','hmlnarik@redhat.com','META-INF/jpa-changelog-authz-4.2.0.Final.xml','2024-10-13 15:23:49',62,'EXECUTED','9:9968206fca46eecc1f51db9c024bfe56','addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.2.0-KEYCLOAK-6313','wadahiro@gmail.com','META-INF/jpa-changelog-4.2.0.xml','2024-10-13 15:23:49',63,'EXECUTED','9:92143a6daea0a3f3b8f598c97ce55c3d','addColumn tableName=REQUIRED_ACTION_PROVIDER','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.3.0-KEYCLOAK-7984','wadahiro@gmail.com','META-INF/jpa-changelog-4.3.0.xml','2024-10-13 15:23:49',64,'EXECUTED','9:82bab26a27195d889fb0429003b18f40','update tableName=REQUIRED_ACTION_PROVIDER','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.6.0-KEYCLOAK-7950','psilva@redhat.com','META-INF/jpa-changelog-4.6.0.xml','2024-10-13 15:23:49',65,'EXECUTED','9:e590c88ddc0b38b0ae4249bbfcb5abc3','update tableName=RESOURCE_SERVER_RESOURCE','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.6.0-KEYCLOAK-8377','keycloak','META-INF/jpa-changelog-4.6.0.xml','2024-10-13 15:23:49',66,'EXECUTED','9:5c1f475536118dbdc38d5d7977950cc0','createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.6.0-KEYCLOAK-8555','gideonray@gmail.com','META-INF/jpa-changelog-4.6.0.xml','2024-10-13 15:23:49',67,'EXECUTED','9:e7c9f5f9c4d67ccbbcc215440c718a17','createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.7.0-KEYCLOAK-1267','sguilhen@redhat.com','META-INF/jpa-changelog-4.7.0.xml','2024-10-13 15:23:49',68,'EXECUTED','9:88e0bfdda924690d6f4e430c53447dd5','addColumn tableName=REALM','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.7.0-KEYCLOAK-7275','keycloak','META-INF/jpa-changelog-4.7.0.xml','2024-10-13 15:23:49',69,'EXECUTED','9:f53177f137e1c46b6a88c59ec1cb5218','renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('4.8.0-KEYCLOAK-8835','sguilhen@redhat.com','META-INF/jpa-changelog-4.8.0.xml','2024-10-13 15:23:49',70,'EXECUTED','9:a74d33da4dc42a37ec27121580d1459f','addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM','',NULL,'4.25.1',NULL,NULL,'8833007157'),('authz-7.0.0-KEYCLOAK-10443','psilva@redhat.com','META-INF/jpa-changelog-authz-7.0.0.xml','2024-10-13 15:23:49',71,'EXECUTED','9:fd4ade7b90c3b67fae0bfcfcb42dfb5f','addColumn tableName=RESOURCE_SERVER','',NULL,'4.25.1',NULL,NULL,'8833007157'),('8.0.0-adding-credential-columns','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-10-13 15:23:49',72,'EXECUTED','9:aa072ad090bbba210d8f18781b8cebf4','addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'8833007157'),('8.0.0-updating-credential-data-not-oracle-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-10-13 15:23:49',73,'EXECUTED','9:1ae6be29bab7c2aa376f6983b932be37','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'8833007157'),('8.0.0-updating-credential-data-oracle-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-10-13 15:23:49',74,'MARK_RAN','9:14706f286953fc9a25286dbd8fb30d97','update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL','',NULL,'4.25.1',NULL,NULL,'8833007157'),('8.0.0-credential-cleanup-fixed','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-10-13 15:23:50',75,'EXECUTED','9:2b9cc12779be32c5b40e2e67711a218b','dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('8.0.0-resource-tag-support','keycloak','META-INF/jpa-changelog-8.0.0.xml','2024-10-13 15:23:50',76,'EXECUTED','9:91fa186ce7a5af127a2d7a91ee083cc5','addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.0-always-display-client','keycloak','META-INF/jpa-changelog-9.0.0.xml','2024-10-13 15:23:50',77,'EXECUTED','9:6335e5c94e83a2639ccd68dd24e2e5ad','addColumn tableName=CLIENT','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.0-drop-constraints-for-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2024-10-13 15:23:50',78,'MARK_RAN','9:6bdb5658951e028bfe16fa0a8228b530','dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.0-increase-column-size-federated-fk','keycloak','META-INF/jpa-changelog-9.0.0.xml','2024-10-13 15:23:50',79,'EXECUTED','9:d5bc15a64117ccad481ce8792d4c608f','modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.0-recreate-constraints-after-column-increase','keycloak','META-INF/jpa-changelog-9.0.0.xml','2024-10-13 15:23:50',80,'MARK_RAN','9:077cba51999515f4d3e7ad5619ab592c','addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.1-add-index-to-client.client_id','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-10-13 15:23:50',81,'EXECUTED','9:be969f08a163bf47c6b9e9ead8ac2afb','createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.1-KEYCLOAK-12579-drop-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-10-13 15:23:50',82,'MARK_RAN','9:6d3bb4408ba5a72f39bd8a0b301ec6e3','dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.1-KEYCLOAK-12579-add-not-null-constraint','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-10-13 15:23:50',83,'EXECUTED','9:966bda61e46bebf3cc39518fbed52fa7','addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.1-KEYCLOAK-12579-recreate-constraints','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-10-13 15:23:50',84,'MARK_RAN','9:8dcac7bdf7378e7d823cdfddebf72fda','addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP','',NULL,'4.25.1',NULL,NULL,'8833007157'),('9.0.1-add-index-to-events','keycloak','META-INF/jpa-changelog-9.0.1.xml','2024-10-13 15:23:50',85,'EXECUTED','9:7d93d602352a30c0c317e6a609b56599','createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY','',NULL,'4.25.1',NULL,NULL,'8833007157'),('map-remove-ri','keycloak','META-INF/jpa-changelog-11.0.0.xml','2024-10-13 15:23:50',86,'EXECUTED','9:71c5969e6cdd8d7b6f47cebc86d37627','dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9','',NULL,'4.25.1',NULL,NULL,'8833007157'),('map-remove-ri','keycloak','META-INF/jpa-changelog-12.0.0.xml','2024-10-13 15:23:51',87,'EXECUTED','9:a9ba7d47f065f041b7da856a81762021','dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('12.1.0-add-realm-localization-table','keycloak','META-INF/jpa-changelog-12.0.0.xml','2024-10-13 15:23:51',88,'EXECUTED','9:fffabce2bc01e1a8f5110d5278500065','createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS','',NULL,'4.25.1',NULL,NULL,'8833007157'),('default-roles','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-10-13 15:23:51',89,'EXECUTED','9:fa8a5b5445e3857f4b010bafb5009957','addColumn tableName=REALM; customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('default-roles-cleanup','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-10-13 15:23:51',90,'EXECUTED','9:67ac3241df9a8582d591c5ed87125f39','dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('13.0.0-KEYCLOAK-16844','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-10-13 15:23:51',91,'EXECUTED','9:ad1194d66c937e3ffc82386c050ba089','createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'8833007157'),('map-remove-ri-13.0.0','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-10-13 15:23:51',92,'EXECUTED','9:d9be619d94af5a2f5d07b9f003543b91','dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('13.0.0-KEYCLOAK-17992-drop-constraints','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-10-13 15:23:51',93,'MARK_RAN','9:544d201116a0fcc5a5da0925fbbc3bde','dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT','',NULL,'4.25.1',NULL,NULL,'8833007157'),('13.0.0-increase-column-size-federated','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-10-13 15:23:51',94,'EXECUTED','9:43c0c1055b6761b4b3e89de76d612ccf','modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT','',NULL,'4.25.1',NULL,NULL,'8833007157'),('13.0.0-KEYCLOAK-17992-recreate-constraints','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-10-13 15:23:51',95,'MARK_RAN','9:8bd711fd0330f4fe980494ca43ab1139','addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('json-string-accomodation-fixed','keycloak','META-INF/jpa-changelog-13.0.0.xml','2024-10-13 15:23:51',96,'EXECUTED','9:e07d2bc0970c348bb06fb63b1f82ddbf','addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE','',NULL,'4.25.1',NULL,NULL,'8833007157'),('14.0.0-KEYCLOAK-11019','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-10-13 15:23:51',97,'EXECUTED','9:24fb8611e97f29989bea412aa38d12b7','createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'8833007157'),('14.0.0-KEYCLOAK-18286','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-10-13 15:23:51',98,'MARK_RAN','9:259f89014ce2506ee84740cbf7163aa7','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('14.0.0-KEYCLOAK-18286-revert','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-10-13 15:23:51',99,'MARK_RAN','9:04baaf56c116ed19951cbc2cca584022','dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('14.0.0-KEYCLOAK-18286-supported-dbs','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-10-13 15:23:51',100,'EXECUTED','9:bd2bd0fc7768cf0845ac96a8786fa735','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('14.0.0-KEYCLOAK-18286-unsupported-dbs','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-10-13 15:23:51',101,'MARK_RAN','9:d3d977031d431db16e2c181ce49d73e9','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('KEYCLOAK-17267-add-index-to-user-attributes','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-10-13 15:23:51',102,'EXECUTED','9:0b305d8d1277f3a89a0a53a659ad274c','createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE','',NULL,'4.25.1',NULL,NULL,'8833007157'),('KEYCLOAK-18146-add-saml-art-binding-identifier','keycloak','META-INF/jpa-changelog-14.0.0.xml','2024-10-13 15:23:51',103,'EXECUTED','9:2c374ad2cdfe20e2905a84c8fac48460','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('15.0.0-KEYCLOAK-18467','keycloak','META-INF/jpa-changelog-15.0.0.xml','2024-10-13 15:23:51',104,'EXECUTED','9:47a760639ac597360a8219f5b768b4de','addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('17.0.0-9562','keycloak','META-INF/jpa-changelog-17.0.0.xml','2024-10-13 15:23:51',105,'EXECUTED','9:a6272f0576727dd8cad2522335f5d99e','createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY','',NULL,'4.25.1',NULL,NULL,'8833007157'),('18.0.0-10625-IDX_ADMIN_EVENT_TIME','keycloak','META-INF/jpa-changelog-18.0.0.xml','2024-10-13 15:23:51',106,'EXECUTED','9:015479dbd691d9cc8669282f4828c41d','createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY','',NULL,'4.25.1',NULL,NULL,'8833007157'),('18.0.15-30992-index-consent','keycloak','META-INF/jpa-changelog-18.0.15.xml','2024-10-13 15:23:51',107,'EXECUTED','9:80071ede7a05604b1f4906f3bf3b00f0','createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE','',NULL,'4.25.1',NULL,NULL,'8833007157'),('19.0.0-10135','keycloak','META-INF/jpa-changelog-19.0.0.xml','2024-10-13 15:23:51',108,'EXECUTED','9:9518e495fdd22f78ad6425cc30630221','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('20.0.0-12964-supported-dbs','keycloak','META-INF/jpa-changelog-20.0.0.xml','2024-10-13 15:23:51',109,'EXECUTED','9:f2e1331a71e0aa85e5608fe42f7f681c','createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE','',NULL,'4.25.1',NULL,NULL,'8833007157'),('20.0.0-12964-unsupported-dbs','keycloak','META-INF/jpa-changelog-20.0.0.xml','2024-10-13 15:23:51',110,'MARK_RAN','9:1a6fcaa85e20bdeae0a9ce49b41946a5','createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE','',NULL,'4.25.1',NULL,NULL,'8833007157'),('client-attributes-string-accomodation-fixed','keycloak','META-INF/jpa-changelog-20.0.0.xml','2024-10-13 15:23:51',111,'EXECUTED','9:3f332e13e90739ed0c35b0b25b7822ca','addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('21.0.2-17277','keycloak','META-INF/jpa-changelog-21.0.2.xml','2024-10-13 15:23:51',112,'EXECUTED','9:7ee1f7a3fb8f5588f171fb9a6ab623c0','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('21.1.0-19404','keycloak','META-INF/jpa-changelog-21.1.0.xml','2024-10-13 15:23:52',113,'EXECUTED','9:3d7e830b52f33676b9d64f7f2b2ea634','modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER','',NULL,'4.25.1',NULL,NULL,'8833007157'),('21.1.0-19404-2','keycloak','META-INF/jpa-changelog-21.1.0.xml','2024-10-13 15:23:52',114,'MARK_RAN','9:627d032e3ef2c06c0e1f73d2ae25c26c','addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('22.0.0-17484-updated','keycloak','META-INF/jpa-changelog-22.0.0.xml','2024-10-13 15:23:52',115,'EXECUTED','9:90af0bfd30cafc17b9f4d6eccd92b8b3','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('22.0.5-24031','keycloak','META-INF/jpa-changelog-22.0.0.xml','2024-10-13 15:23:52',116,'MARK_RAN','9:a60d2d7b315ec2d3eba9e2f145f9df28','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('23.0.0-12062','keycloak','META-INF/jpa-changelog-23.0.0.xml','2024-10-13 15:23:52',117,'EXECUTED','9:2168fbe728fec46ae9baf15bf80927b8','addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG','',NULL,'4.25.1',NULL,NULL,'8833007157'),('23.0.0-17258','keycloak','META-INF/jpa-changelog-23.0.0.xml','2024-10-13 15:23:52',118,'EXECUTED','9:36506d679a83bbfda85a27ea1864dca8','addColumn tableName=EVENT_ENTITY','',NULL,'4.25.1',NULL,NULL,'8833007157'),('24.0.0-9758','keycloak','META-INF/jpa-changelog-24.0.0.xml','2024-10-13 15:23:52',119,'EXECUTED','9:502c557a5189f600f0f445a9b49ebbce','addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('24.0.0-9758-2','keycloak','META-INF/jpa-changelog-24.0.0.xml','2024-10-13 15:23:52',120,'EXECUTED','9:bf0fdee10afdf597a987adbf291db7b2','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('24.0.0-26618-drop-index-if-present','keycloak','META-INF/jpa-changelog-24.0.0.xml','2024-10-13 15:23:52',121,'EXECUTED','9:04baaf56c116ed19951cbc2cca584022','dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('24.0.0-26618-reindex','keycloak','META-INF/jpa-changelog-24.0.0.xml','2024-10-13 15:23:52',122,'EXECUTED','9:bd2bd0fc7768cf0845ac96a8786fa735','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('24.0.2-27228','keycloak','META-INF/jpa-changelog-24.0.2.xml','2024-10-13 15:23:52',123,'EXECUTED','9:eaee11f6b8aa25d2cc6a84fb86fc6238','customChange','',NULL,'4.25.1',NULL,NULL,'8833007157'),('24.0.2-27967-drop-index-if-present','keycloak','META-INF/jpa-changelog-24.0.2.xml','2024-10-13 15:23:52',124,'MARK_RAN','9:04baaf56c116ed19951cbc2cca584022','dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('24.0.2-27967-reindex','keycloak','META-INF/jpa-changelog-24.0.2.xml','2024-10-13 15:23:52',125,'MARK_RAN','9:d3d977031d431db16e2c181ce49d73e9','createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES','',NULL,'4.25.1',NULL,NULL,'8833007157'),('25.0.0-28265-tables','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',126,'EXECUTED','9:deda2df035df23388af95bbd36c17cef','addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION','',NULL,'4.25.1',NULL,NULL,'8833007157'),('25.0.0-28265-index-creation','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',127,'EXECUTED','9:3e96709818458ae49f3c679ae58d263a','createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'8833007157'),('25.0.0-28265-index-cleanup','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',128,'EXECUTED','9:8c0cfa341a0474385b324f5c4b2dfcc1','dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION; dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION; dropIndex ...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('25.0.0-28265-index-2-mysql','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',129,'EXECUTED','9:b7ef76036d3126bb83c2423bf4d449d6','createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'8833007157'),('25.0.0-28265-index-2-not-mysql','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',130,'MARK_RAN','9:23396cf51ab8bc1ae6f0cac7f9f6fcf7','createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION','',NULL,'4.25.1',NULL,NULL,'8833007157'),('25.0.0-org','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',131,'EXECUTED','9:5c859965c2c9b9c72136c360649af157','createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN','',NULL,'4.25.1',NULL,NULL,'8833007157'),('unique-consentuser','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',132,'MARK_RAN','9:5857626a2ea8767e9a6c66bf3a2cb32f','customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('unique-consentuser-mysql','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',133,'EXECUTED','9:b79478aad5adaa1bc428e31563f55e8e','customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...','',NULL,'4.25.1',NULL,NULL,'8833007157'),('25.0.0-28861-index-creation','keycloak','META-INF/jpa-changelog-25.0.0.xml','2024-10-13 15:23:52',134,'EXECUTED','9:b9acb58ac958d9ada0fe12a5d4794ab1','createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET','',NULL,'4.25.1',NULL,NULL,'8833007157');
/*!40000 ALTER TABLE `databasechangelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `databasechangeloglock`
--

DROP TABLE IF EXISTS `databasechangeloglock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `databasechangeloglock` (
  `ID` int NOT NULL,
  `LOCKED` tinyint NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `databasechangeloglock`
--

LOCK TABLES `databasechangeloglock` WRITE;
/*!40000 ALTER TABLE `databasechangeloglock` DISABLE KEYS */;
INSERT INTO `databasechangeloglock` VALUES (1,0,NULL,NULL),(1000,0,NULL,NULL);
/*!40000 ALTER TABLE `databasechangeloglock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEFAULT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `DEFAULT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DEFAULT_CLIENT_SCOPE` (
  `REALM_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  `DEFAULT_SCOPE` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`REALM_ID`,`SCOPE_ID`),
  KEY `IDX_DEFCLS_REALM` (`REALM_ID`),
  KEY `IDX_DEFCLS_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_R_DEF_CLI_SCOPE_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEFAULT_CLIENT_SCOPE`
--

LOCK TABLES `DEFAULT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` DISABLE KEYS */;
INSERT INTO `DEFAULT_CLIENT_SCOPE` VALUES ('15e56e88-e77b-45e1-afa4-0d9a64309354','34668ee5-d79f-4b1c-8116-44ace66dfdeb',0),('15e56e88-e77b-45e1-afa4-0d9a64309354','4e6cc391-6c83-49b0-9d81-cba74e0a48ea',1),('15e56e88-e77b-45e1-afa4-0d9a64309354','6617ecae-8bd4-412f-8458-4f9f19cebd63',1),('15e56e88-e77b-45e1-afa4-0d9a64309354','66701909-f2ee-4c19-b5c9-b0375978d11d',1),('15e56e88-e77b-45e1-afa4-0d9a64309354','a47ac21b-c943-4367-b439-05d79ab4b602',1),('15e56e88-e77b-45e1-afa4-0d9a64309354','a927d35f-5ba7-43ef-aebd-99b06490882f',0),('15e56e88-e77b-45e1-afa4-0d9a64309354','a9d8695b-ba1a-448c-aa44-0b2665231af0',1),('15e56e88-e77b-45e1-afa4-0d9a64309354','ba5a618d-eb38-4b3d-89f0-930d25469cb7',1),('15e56e88-e77b-45e1-afa4-0d9a64309354','c2c7d4fc-6967-49ad-ba95-1cc64bee1b99',0),('15e56e88-e77b-45e1-afa4-0d9a64309354','ddc596ff-e80b-4989-b2b3-32335e07740c',0),('15e56e88-e77b-45e1-afa4-0d9a64309354','fdc515e3-b32a-422e-ab97-21e20521dc15',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0009537e-c0b6-42d2-bc03-0f444c1c2774',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','226c15bb-33ef-4845-931d-27f03df6d065',0),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','26ad2e0f-2858-4708-9f0e-b36ef5957ab5',0),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','5106d93d-d258-4751-af11-3e885fe20567',0),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','68a14bef-30aa-4c9a-b2df-2d872039e915',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','91deb1f1-3467-4a17-9bdc-cc27a9cefbb5',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','a6fcc2db-5e24-4ebf-baa6-142bf1e18d26',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ae5179e3-c137-4211-9a53-4c4e72f2096a',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','dc4f4018-0584-4f37-964d-eca9cc2aa99d',1),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','f0296697-946e-456e-b265-7c36b92726e7',0),('f65da957-0a1a-47d4-9781-0118b7c15e3d','08cc9784-abae-4222-b79c-a29c1c80d32f',1),('f65da957-0a1a-47d4-9781-0118b7c15e3d','095e48a0-40c6-47c0-b438-2b3baa2acb37',0),('f65da957-0a1a-47d4-9781-0118b7c15e3d','1ae55ce0-138f-491e-8f40-d72f2cde4590',1),('f65da957-0a1a-47d4-9781-0118b7c15e3d','3faf99cf-6f15-430a-bb1b-82cb86e2a5df',1),('f65da957-0a1a-47d4-9781-0118b7c15e3d','49009358-8fa1-4996-b77a-179509d8edfc',1),('f65da957-0a1a-47d4-9781-0118b7c15e3d','87b0ace7-ebb0-4465-94ab-6f8f993a234a',0),('f65da957-0a1a-47d4-9781-0118b7c15e3d','947d8eb2-d905-4564-8524-245ec1c97604',1),('f65da957-0a1a-47d4-9781-0118b7c15e3d','a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2',0),('f65da957-0a1a-47d4-9781-0118b7c15e3d','b6084802-f03c-4500-a791-9d426d94b78f',0),('f65da957-0a1a-47d4-9781-0118b7c15e3d','e52eb992-13f7-4886-a3b7-0e3df3a4e338',1),('f65da957-0a1a-47d4-9781-0118b7c15e3d','ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3',1);
/*!40000 ALTER TABLE `DEFAULT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EVENT_ENTITY`
--

DROP TABLE IF EXISTS `EVENT_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EVENT_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON` text,
  `ERROR` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `SESSION_ID` varchar(255) DEFAULT NULL,
  `EVENT_TIME` bigint DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `DETAILS_JSON_LONG_VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_EVENT_TIME` (`REALM_ID`,`EVENT_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EVENT_ENTITY`
--

LOCK TABLES `EVENT_ENTITY` WRITE;
/*!40000 ALTER TABLE `EVENT_ENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `EVENT_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `FED_USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `VALUE` text,
  `LONG_VALUE_HASH` binary(64) DEFAULT NULL,
  `LONG_VALUE_HASH_LOWER_CASE` binary(64) DEFAULT NULL,
  `LONG_VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_ATTRIBUTE` (`USER_ID`,`REALM_ID`,`NAME`),
  KEY `FED_USER_ATTR_LONG_VALUES` (`LONG_VALUE_HASH`,`NAME`),
  KEY `FED_USER_ATTR_LONG_VALUES_LOWER_CASE` (`LONG_VALUE_HASH_LOWER_CASE`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ATTRIBUTE`
--

LOCK TABLES `FED_USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CONSENT` (`USER_ID`,`CLIENT_ID`),
  KEY `IDX_FU_CONSENT_RU` (`REALM_ID`,`USER_ID`),
  KEY `IDX_FU_CNSNT_EXT` (`USER_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT`
--

LOCK TABLES `FED_USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CONSENT_CL_SCOPE`
--

DROP TABLE IF EXISTS `FED_USER_CONSENT_CL_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CONSENT_CL_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CONSENT_CL_SCOPE`
--

LOCK TABLES `FED_USER_CONSENT_CL_SCOPE` WRITE;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CONSENT_CL_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_CREDENTIAL`
--

DROP TABLE IF EXISTS `FED_USER_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_CREDENTIAL` (
  `ID` varchar(36) NOT NULL,
  `SALT` tinyblob,
  `TYPE` varchar(255) DEFAULT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  `USER_LABEL` varchar(255) DEFAULT NULL,
  `SECRET_DATA` longtext,
  `CREDENTIAL_DATA` longtext,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_FU_CREDENTIAL` (`USER_ID`,`TYPE`),
  KEY `IDX_FU_CREDENTIAL_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_CREDENTIAL`
--

LOCK TABLES `FED_USER_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `FED_USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP` (`USER_ID`,`GROUP_ID`),
  KEY `IDX_FU_GROUP_MEMBERSHIP_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `FED_USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `FED_USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_REQUIRED_ACTION` (
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_FU_REQUIRED_ACTION` (`USER_ID`,`REQUIRED_ACTION`),
  KEY `IDX_FU_REQUIRED_ACTION_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_REQUIRED_ACTION`
--

LOCK TABLES `FED_USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FED_USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `FED_USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FED_USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_FU_ROLE_MAPPING` (`USER_ID`,`ROLE_ID`),
  KEY `IDX_FU_ROLE_MAPPING_RU` (`REALM_ID`,`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FED_USER_ROLE_MAPPING`
--

LOCK TABLES `FED_USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `FED_USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_IDENTITY`
--

DROP TABLE IF EXISTS `FEDERATED_IDENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FEDERATED_IDENTITY` (
  `IDENTITY_PROVIDER` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `FEDERATED_USER_ID` varchar(255) DEFAULT NULL,
  `FEDERATED_USERNAME` varchar(255) DEFAULT NULL,
  `TOKEN` text,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER`,`USER_ID`),
  KEY `IDX_FEDIDENTITY_USER` (`USER_ID`),
  KEY `IDX_FEDIDENTITY_FEDUSER` (`FEDERATED_USER_ID`),
  CONSTRAINT `FK404288B92EF007A6` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_IDENTITY`
--

LOCK TABLES `FEDERATED_IDENTITY` WRITE;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_IDENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FEDERATED_USER`
--

DROP TABLE IF EXISTS `FEDERATED_USER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `FEDERATED_USER` (
  `ID` varchar(255) NOT NULL,
  `STORAGE_PROVIDER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FEDERATED_USER`
--

LOCK TABLES `FEDERATED_USER` WRITE;
/*!40000 ALTER TABLE `FEDERATED_USER` DISABLE KEYS */;
/*!40000 ALTER TABLE `FEDERATED_USER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ATTRIBUTE`
--

DROP TABLE IF EXISTS `GROUP_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GROUP_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_GROUP_ATTR_GROUP` (`GROUP_ID`),
  KEY `IDX_GROUP_ATT_BY_NAME_VALUE` (`NAME`,`VALUE`),
  CONSTRAINT `FK_GROUP_ATTRIBUTE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ATTRIBUTE`
--

LOCK TABLES `GROUP_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GROUP_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `GROUP_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `GROUP_ROLE_MAPPING` (
  `ROLE_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`GROUP_ID`),
  KEY `IDX_GROUP_ROLE_MAPP_GROUP` (`GROUP_ID`),
  CONSTRAINT `FK_GROUP_ROLE_GROUP` FOREIGN KEY (`GROUP_ID`) REFERENCES `KEYCLOAK_GROUP` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GROUP_ROLE_MAPPING`
--

LOCK TABLES `GROUP_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` DISABLE KEYS */;
/*!40000 ALTER TABLE `GROUP_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER` (
  `INTERNAL_ID` varchar(36) NOT NULL,
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `PROVIDER_ALIAS` varchar(255) DEFAULT NULL,
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `STORE_TOKEN` tinyint NOT NULL DEFAULT '0',
  `AUTHENTICATE_BY_DEFAULT` tinyint NOT NULL DEFAULT '0',
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ADD_TOKEN_ROLE` tinyint NOT NULL DEFAULT '1',
  `TRUST_EMAIL` tinyint NOT NULL DEFAULT '0',
  `FIRST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `POST_BROKER_LOGIN_FLOW_ID` varchar(36) DEFAULT NULL,
  `PROVIDER_DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `LINK_ONLY` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`INTERNAL_ID`),
  UNIQUE KEY `UK_2DAELWNIBJI49AVXSRTUF6XJ33` (`PROVIDER_ALIAS`,`REALM_ID`),
  KEY `IDX_IDENT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK2B4EBC52AE5C3B34` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER`
--

LOCK TABLES `IDENTITY_PROVIDER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_CONFIG`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER_CONFIG` (
  `IDENTITY_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDENTITY_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FKDC4897CF864C4E43` FOREIGN KEY (`IDENTITY_PROVIDER_ID`) REFERENCES `IDENTITY_PROVIDER` (`INTERNAL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_CONFIG`
--

LOCK TABLES `IDENTITY_PROVIDER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDENTITY_PROVIDER_MAPPER`
--

DROP TABLE IF EXISTS `IDENTITY_PROVIDER_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDENTITY_PROVIDER_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `IDP_ALIAS` varchar(255) NOT NULL,
  `IDP_MAPPER_NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ID_PROV_MAPP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_IDPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDENTITY_PROVIDER_MAPPER`
--

LOCK TABLES `IDENTITY_PROVIDER_MAPPER` WRITE;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDENTITY_PROVIDER_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IDP_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `IDP_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IDP_MAPPER_CONFIG` (
  `IDP_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`IDP_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_IDPMCONFIG` FOREIGN KEY (`IDP_MAPPER_ID`) REFERENCES `IDENTITY_PROVIDER_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IDP_MAPPER_CONFIG`
--

LOCK TABLES `IDP_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `IDP_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_GROUP`
--

DROP TABLE IF EXISTS `KEYCLOAK_GROUP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KEYCLOAK_GROUP` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `PARENT_GROUP` varchar(36) NOT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `SIBLING_NAMES` (`REALM_ID`,`PARENT_GROUP`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_GROUP`
--

LOCK TABLES `KEYCLOAK_GROUP` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` DISABLE KEYS */;
/*!40000 ALTER TABLE `KEYCLOAK_GROUP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `KEYCLOAK_ROLE`
--

DROP TABLE IF EXISTS `KEYCLOAK_ROLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `KEYCLOAK_ROLE` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_REALM_CONSTRAINT` varchar(255) DEFAULT NULL,
  `CLIENT_ROLE` tinyint DEFAULT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `CLIENT` varchar(36) DEFAULT NULL,
  `REALM` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_J3RWUVD56ONTGSUHOGM184WW2-2` (`NAME`,`CLIENT_REALM_CONSTRAINT`),
  KEY `IDX_KEYCLOAK_ROLE_CLIENT` (`CLIENT`),
  KEY `IDX_KEYCLOAK_ROLE_REALM` (`REALM`),
  CONSTRAINT `FK_6VYQFE4CN4WLQ8R6KT5VDSJ5C` FOREIGN KEY (`REALM`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `KEYCLOAK_ROLE`
--

LOCK TABLES `KEYCLOAK_ROLE` WRITE;
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` DISABLE KEYS */;
INSERT INTO `KEYCLOAK_ROLE` VALUES ('014a86c7-affa-4af1-872c-162c749766eb','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_manage-clients}','manage-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('0189d22a-a266-40c4-bfd1-9633b2e7a385','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_view-authorization}','view-authorization','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('01c1d07d-b2ee-4a72-894e-c0af54e9f546','f65da957-0a1a-47d4-9781-0118b7c15e3d',0,'${role_create-realm}','create-realm','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL,NULL),('02a256d5-7f6b-4d92-84c0-6ec45fe82a60','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,'${role_manage-account-links}','manage-account-links','f65da957-0a1a-47d4-9781-0118b7c15e3d','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',NULL),('02a8223a-61d9-453c-9e61-c10ac88c5f34','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',1,NULL,'uma_protection','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',NULL),('03585491-7c7f-4442-8b35-7f9103d8f867','15e56e88-e77b-45e1-afa4-0d9a64309354',0,'${role_uma_authorization}','uma_authorization','15e56e88-e77b-45e1-afa4-0d9a64309354',NULL,NULL),('05ab7526-624b-4280-8c33-01bc92d91b8c','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_manage-identity-providers}','manage-identity-providers','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('095e2fe8-5c95-47c8-a00e-9c838e27158a','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_manage-realm}','manage-realm','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('10a68de3-37a3-4dba-a7b1-93c46f301301','df6ec42c-bf1a-4469-8a5f-fc30b17802bb',1,NULL,'manage-account','15e56e88-e77b-45e1-afa4-0d9a64309354','df6ec42c-bf1a-4469-8a5f-fc30b17802bb',NULL),('10d932c4-fab2-45e8-af69-f9bd9c8f34b8','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_view-events}','view-events','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('1383d857-16f6-4b23-a33c-4faf641f0d11','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_manage-identity-providers}','manage-identity-providers','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('1483f8b3-ed2e-484d-9d69-0c12d5d243dd','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_query-users}','query-users','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('150a8f99-7152-452a-90e0-fbe3513b9017','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_view-clients}','view-clients','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('19afba7d-1ce9-4d1f-ad98-d6f9beefef00','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_query-users}','query-users','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('1fe4547f-02b7-4627-8fce-577578e107a0','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_manage-identity-providers}','manage-identity-providers','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('221f6c73-5959-4467-82f5-025add48b94e','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_query-clients}','query-clients','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('23cc61cf-547e-404c-9cff-b995591fe5bc','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,'${role_manage-account}','manage-account','f65da957-0a1a-47d4-9781-0118b7c15e3d','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',NULL),('2425bcd2-e399-4d65-b59a-4c4d991ff9ab','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_manage-authorization}','manage-authorization','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('2bede393-3463-4edb-8339-cfa293adfbec','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_manage-users}','manage-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('2c9aacd1-a584-4307-90c2-4815cbf192a9','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_query-realms}','query-realms','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('2ef1b15e-bdb5-4bc1-bf64-882af80d2b9d','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_query-groups}','query-groups','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('2fecdb8d-3468-4127-94b7-86496e9a0d82','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_impersonation}','impersonation','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('304d958d-37ee-4c2a-ba28-e77e04639ab9','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_view-identity-providers}','view-identity-providers','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('309ec902-53da-45be-8b2f-073bb925a0e5','c50f75ca-b516-4ca8-ae8a-220102762e0b',1,'${role_delete-account}','delete-account','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',NULL),('36550a8c-4f99-463b-abca-59a23407df92','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',0,'${role_offline-access}','offline_access','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL,NULL),('36999e33-c913-46b4-86e5-3b582284be0c','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_view-identity-providers}','view-identity-providers','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('38671a58-41d1-41ff-8ae6-aa7f0dad6d96','f65da957-0a1a-47d4-9781-0118b7c15e3d',0,'${role_offline-access}','offline_access','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL,NULL),('3ad05b7f-013f-4190-b345-7fa00cff2caf','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_view-events}','view-events','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('3cf35d9a-ad2a-4274-95e3-607901f3debe','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_manage-events}','manage-events','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('3db23f3d-9fb5-46a2-b464-a724a54d5876','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_query-clients}','query-clients','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('3ec301b3-7690-4be7-b78a-c4ac784f15bf','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_impersonation}','impersonation','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('3f234307-1a91-49b5-bb56-77fc8fb39a94','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_manage-authorization}','manage-authorization','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('4063d441-7d8f-4b2c-aec7-7626b61dd594','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,'${role_manage-consent}','manage-consent','f65da957-0a1a-47d4-9781-0118b7c15e3d','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',NULL),('42658cca-faa2-4555-991c-59ed8c836fc4','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_query-groups}','query-groups','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('440823d2-a674-4acd-899c-5171cf943e0d','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_manage-clients}','manage-clients','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('4472ae79-9d85-4a0a-b78d-5d8d548664b0','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,'${role_view-applications}','view-applications','f65da957-0a1a-47d4-9781-0118b7c15e3d','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',NULL),('4aba48c1-16f6-4fd0-b756-7a0de4ef5a57','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_view-users}','view-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('4b897cd9-a6b0-4853-ae68-0a4c74f40bde','15e56e88-e77b-45e1-afa4-0d9a64309354',0,'${role_offline-access}','offline_access','15e56e88-e77b-45e1-afa4-0d9a64309354',NULL,NULL),('4dc3640a-58cc-47a0-b8c2-e789b33855ea','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_create-client}','create-client','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('50ee3323-63e2-47cd-b06f-fc1b97b61cc1','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,'${role_view-groups}','view-groups','f65da957-0a1a-47d4-9781-0118b7c15e3d','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',NULL),('5466bc49-f61e-4a59-9cdc-91e28451f724','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_view-realm}','view-realm','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('55d931ea-83eb-4631-9d4c-79322b08dc2f','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_create-client}','create-client','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('5639907f-e233-4a72-9682-befc1b25c86f','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_view-realm}','view-realm','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('5a98df6b-33b5-4190-a825-40c7780a1cdb','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_manage-users}','manage-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('5b1a3184-aae1-4abe-9362-9e1afe799683','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_create-client}','create-client','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('5c97bfe1-13ad-492a-ab0a-f8b9e25e5654','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,'${role_delete-account}','delete-account','f65da957-0a1a-47d4-9781-0118b7c15e3d','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',NULL),('5d44308e-ae3f-4aab-be8d-717c8581ae16','3e7a4490-b72d-4b32-8e88-1a76cef6a8ab',1,'${role_read-token}','read-token','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','3e7a4490-b72d-4b32-8e88-1a76cef6a8ab',NULL),('6066858c-4b76-463a-99b8-4fbf1f2e005c','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_impersonation}','impersonation','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('61f2ba25-88d0-4497-b52d-258fd324d3e1','c50f75ca-b516-4ca8-ae8a-220102762e0b',1,'${role_view-groups}','view-groups','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',NULL),('6481e013-17b1-450f-9ab1-f5e0dcf042d7','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_manage-events}','manage-events','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('64df9e25-5d24-4027-baca-aebb78fde590','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_view-authorization}','view-authorization','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('6c26d85d-1aac-4541-9eaa-6a54bd630e48','c50f75ca-b516-4ca8-ae8a-220102762e0b',1,'${role_view-consent}','view-consent','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',NULL),('6dcdbafa-c197-4c3a-aba5-9f2e0fcb8ad6','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_manage-users}','manage-users','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('6e84f520-ca4c-4e14-bda0-fdd2c712bbab','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_query-groups}','query-groups','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('700825d6-4083-4276-8f10-8162318b2305','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_view-authorization}','view-authorization','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('70c15f4f-78dc-43ca-950a-f07c219e077b','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_query-clients}','query-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('781f94d6-7b7c-4a17-9390-5945f0977b4e','c50f75ca-b516-4ca8-ae8a-220102762e0b',1,'${role_view-profile}','view-profile','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',NULL),('78c49721-0172-4205-b80c-0f60b245eeaf','c50f75ca-b516-4ca8-ae8a-220102762e0b',1,'${role_manage-account-links}','manage-account-links','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',NULL),('7a82718b-9b41-4047-a4c5-c073d924e407','df6ec42c-bf1a-4469-8a5f-fc30b17802bb',1,'${role_delete-account}','delete-account','15e56e88-e77b-45e1-afa4-0d9a64309354','df6ec42c-bf1a-4469-8a5f-fc30b17802bb',NULL),('7ab580eb-b26c-4110-9208-1b5bdf2ad40b','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',0,'${role_uma_authorization}','uma_authorization','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL,NULL),('7b149774-efd3-477b-b9f5-4fa474ae319f','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_create-client}','create-client','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('7b73b976-9f80-4b0d-b362-3fa7274f980f','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_query-realms}','query-realms','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('807057a1-7277-463d-a205-ae04b64b45c1','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_realm-admin}','realm-admin','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('8208b6a2-d173-4a7b-9e6e-cdd600204dbe','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,'${role_view-profile}','view-profile','f65da957-0a1a-47d4-9781-0118b7c15e3d','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',NULL),('82a090ea-efe4-4141-a859-f31a2c687997','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_view-identity-providers}','view-identity-providers','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('83c859c0-2676-4e2b-858e-6fc1545e4800','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_manage-events}','manage-events','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('84bc01dd-629b-4090-86e5-5d0b10c9877d','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_view-realm}','view-realm','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('8645209c-81b6-470f-a1a1-c81a06ea0403','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_query-users}','query-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('87c2becb-eb0d-4272-b78c-3c2aac9c0bb0','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_view-clients}','view-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('888f0324-6c7f-4354-adf8-a89029384d9d','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_view-identity-providers}','view-identity-providers','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('8d14bc18-5839-4940-8a48-ea12cae65d56','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_create-client}','create-client','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('931e92ad-7859-4fcf-afc4-5edcfe9b2384','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_manage-authorization}','manage-authorization','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('938d2359-8711-4110-a5d7-768c38a27965','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_manage-identity-providers}','manage-identity-providers','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('93f198f6-cf1d-432f-9d6e-25aaccadd875','f65da957-0a1a-47d4-9781-0118b7c15e3d',0,'${role_admin}','admin','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL,NULL),('97ccf601-9d0c-42c5-85b7-cc660c268b58','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_query-realms}','query-realms','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('986b1529-6e82-47bb-b98e-2d0c1d1e2af8','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_view-users}','view-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('98763f74-f973-4360-a387-83bc348b5514','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_query-users}','query-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('99108855-2637-4e7d-bfe3-6f492b037c6d','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_view-users}','view-users','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('9a460e54-da96-4919-b647-d0d3397205f3','15e56e88-e77b-45e1-afa4-0d9a64309354',0,'${role_default-roles}','default-roles-nextjs','15e56e88-e77b-45e1-afa4-0d9a64309354',NULL,NULL),('9b3f0026-b933-4bb8-98c9-6440edcff1e7','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_view-authorization}','view-authorization','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('9bdad5c1-868b-4be4-ba62-3a22417607a7','c50f75ca-b516-4ca8-ae8a-220102762e0b',1,'${role_view-applications}','view-applications','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',NULL),('9c3a679a-2563-486c-aa42-fe8e07a80a19','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_manage-realm}','manage-realm','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('a2f57d4a-97ca-4fe5-813a-36e942bbd785','f65da957-0a1a-47d4-9781-0118b7c15e3d',0,'${role_default-roles}','default-roles-master','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL,NULL),('a4853fe7-e154-4896-98f5-eafe79a5280d','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_view-identity-providers}','view-identity-providers','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('a48fee1e-1ad1-40b3-b2ab-1b51492bf697','f65da957-0a1a-47d4-9781-0118b7c15e3d',0,'${role_uma_authorization}','uma_authorization','f65da957-0a1a-47d4-9781-0118b7c15e3d',NULL,NULL),('aef6402f-979d-409e-9d08-21eec85c4435','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_view-events}','view-events','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('b46a87dc-2cad-4bc7-9c66-2541714a8f65','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_view-clients}','view-clients','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('b49341ad-3e39-4eb6-a238-6fddb4525557','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_view-clients}','view-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('b5b275ea-77e2-4354-8388-1ee633125fa0','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_view-events}','view-events','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('b64d2f95-10a3-40fc-9570-76a385a00f90','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_manage-users}','manage-users','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('b6da413d-011a-4965-86d2-0479fddf5187','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_view-events}','view-events','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('b71f4109-e25e-4453-bcd7-90157deaa0c9','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_manage-authorization}','manage-authorization','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('b74b50ad-005f-4ed3-9c14-ea5161346a90','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_query-realms}','query-realms','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('b7e599fd-ccf2-4f75-b7ce-a1e08b7c3cb3','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_query-users}','query-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('bd515cff-8940-4b64-a4ce-1ff34473a69e','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_manage-identity-providers}','manage-identity-providers','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('c0e16b01-2108-419b-a825-fa8891082407','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_view-authorization}','view-authorization','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('c137756b-cae9-462a-b02d-ba02e9b79228','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_view-realm}','view-realm','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('c51673ae-e96c-4d92-813c-8f21223b6ba0','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_impersonation}','impersonation','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('c996812f-1924-40aa-b53b-d426d5da98b1','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',1,'${role_view-consent}','view-consent','f65da957-0a1a-47d4-9781-0118b7c15e3d','0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae',NULL),('cbd47c4a-9c2a-4217-9250-77e646b1b688','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_query-groups}','query-groups','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('ccfc31db-84d9-4bb4-a315-1aaa6d1eb81d','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_manage-events}','manage-events','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('d12c5222-7a5b-40ec-8f71-9b1db27b6488','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_manage-users}','manage-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('d206f4f1-4605-4a70-bb6b-7a38cc7a38d9','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_view-realm}','view-realm','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('d70f6e26-e9b5-424a-b7c5-76487bc11eaf','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_view-users}','view-users','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('d751f761-0bd8-4eae-9487-9331afbfd6e4','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_query-clients}','query-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('db95f9e5-b5f9-46e7-bd7c-f0746ea3fc5d','350c9c5c-ad9e-465c-a040-054e24aae52c',1,'${role_read-token}','read-token','f65da957-0a1a-47d4-9781-0118b7c15e3d','350c9c5c-ad9e-465c-a040-054e24aae52c',NULL),('dde77f95-83f6-4206-9262-e3e22044819a','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_manage-realm}','manage-realm','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('de5c1bf9-a6e7-49ae-b5fc-5129ec1a9cc2','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_manage-authorization}','manage-authorization','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('e077c769-f87c-419d-a7e3-5c1e1fe91168','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',0,'User Role','user','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL,NULL),('e23ba581-fb61-426c-8a6e-578accb4b53e','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_view-clients}','view-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('e4006004-2633-4b86-afec-1ceb2cc43da2','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_manage-realm}','manage-realm','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('e4ad8c8e-24f5-4d5f-8625-aec603709762','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_query-groups}','query-groups','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('e4fecb29-e432-41a7-b3e4-4f9e3785fc61','8f68b73b-954d-4245-9882-551d3823aa52',1,'${role_manage-clients}','manage-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','8f68b73b-954d-4245-9882-551d3823aa52',NULL),('e5db9456-f70a-4a46-a55c-d7d02cc26356','3d696010-2dc7-442c-9ec9-ecb743e382af',1,'${role_view-users}','view-users','15e56e88-e77b-45e1-afa4-0d9a64309354','3d696010-2dc7-442c-9ec9-ecb743e382af',NULL),('eb61848a-4bce-406d-b73b-2d4489ee4be2','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_manage-clients}','manage-clients','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('eec3c8fc-2436-498a-ae9a-ba018c445250','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_manage-realm}','manage-realm','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('efcea55c-be64-401d-a1d7-6bc3557250ec','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',0,'Admin Role','admin','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL,NULL),('f1280c1e-2251-4910-ae43-eadba9f9f379','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',0,'${role_default-roles}','default-roles-forum','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL,NULL),('f17e72db-6b3d-4fdc-a322-c5b447ff9a13','c50f75ca-b516-4ca8-ae8a-220102762e0b',1,'${role_manage-consent}','manage-consent','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',NULL),('f4f8dcf0-61d8-48b2-982d-3190aa8b52bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',1,'${role_manage-account}','manage-account','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','c50f75ca-b516-4ca8-ae8a-220102762e0b',NULL),('f80a66f3-93b8-47bb-8546-0652eef90a46','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_manage-clients}','manage-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('f8ee14a9-1356-4e2a-9197-082b8725ba59','899df6e9-d50a-4662-813c-fc672edcdbdf',1,'${role_manage-events}','manage-events','f65da957-0a1a-47d4-9781-0118b7c15e3d','899df6e9-d50a-4662-813c-fc672edcdbdf',NULL),('fafbbc78-d8bc-43de-8b2c-80b7b17fa58c','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_impersonation}','impersonation','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('fb0996a0-090c-4789-906c-429e57a4dfab','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',0,NULL,'inactive','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',NULL,NULL),('fba80ab2-e523-49e9-844b-6020172821fd','df6ec42c-bf1a-4469-8a5f-fc30b17802bb',1,NULL,'view-groups','15e56e88-e77b-45e1-afa4-0d9a64309354','df6ec42c-bf1a-4469-8a5f-fc30b17802bb',NULL),('fc0c9472-8c2a-4bf0-b905-1869c53c7659','1fc8e766-9ec9-49e7-ad45-f76655d6508c',1,'${role_query-clients}','query-clients','f65da957-0a1a-47d4-9781-0118b7c15e3d','1fc8e766-9ec9-49e7-ad45-f76655d6508c',NULL),('fc199046-925d-4680-a317-34be8a5b0a9e','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_realm-admin}','realm-admin','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL),('fdf3016c-8019-4788-aafc-f79b285e3e32','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',1,'${role_query-realms}','query-realms','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0234b9da-34e6-4f3f-a6d2-fe08ae1caf58',NULL);
/*!40000 ALTER TABLE `KEYCLOAK_ROLE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MIGRATION_MODEL`
--

DROP TABLE IF EXISTS `MIGRATION_MODEL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MIGRATION_MODEL` (
  `ID` varchar(36) NOT NULL,
  `VERSION` varchar(36) DEFAULT NULL,
  `UPDATE_TIME` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `IDX_UPDATE_TIME` (`UPDATE_TIME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MIGRATION_MODEL`
--

LOCK TABLES `MIGRATION_MODEL` WRITE;
/*!40000 ALTER TABLE `MIGRATION_MODEL` DISABLE KEYS */;
INSERT INTO `MIGRATION_MODEL` VALUES ('56y9d','25.0.2',1728833033);
/*!40000 ALTER TABLE `MIGRATION_MODEL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_CLIENT_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_CLIENT_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OFFLINE_CLIENT_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `TIMESTAMP` int DEFAULT NULL,
  `DATA` longtext,
  `CLIENT_STORAGE_PROVIDER` varchar(36) NOT NULL DEFAULT 'local',
  `EXTERNAL_CLIENT_ID` varchar(255) NOT NULL DEFAULT 'local',
  `VERSION` int DEFAULT '0',
  PRIMARY KEY (`USER_SESSION_ID`,`CLIENT_ID`,`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`OFFLINE_FLAG`),
  KEY `IDX_US_SESS_ID_ON_CL_SESS` (`USER_SESSION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_CLIENT_SESSION`
--

LOCK TABLES `OFFLINE_CLIENT_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFLINE_CLIENT_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFLINE_USER_SESSION`
--

DROP TABLE IF EXISTS `OFFLINE_USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `OFFLINE_USER_SESSION` (
  `USER_SESSION_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `CREATED_ON` int NOT NULL,
  `OFFLINE_FLAG` varchar(4) NOT NULL,
  `DATA` longtext,
  `LAST_SESSION_REFRESH` int NOT NULL DEFAULT '0',
  `BROKER_SESSION_ID` text,
  `VERSION` int DEFAULT '0',
  PRIMARY KEY (`USER_SESSION_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_BY_USER` (`USER_ID`,`REALM_ID`,`OFFLINE_FLAG`),
  KEY `IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH` (`REALM_ID`,`OFFLINE_FLAG`,`LAST_SESSION_REFRESH`),
  KEY `IDX_OFFLINE_USS_BY_BROKER_SESSION_ID` (`BROKER_SESSION_ID`(255),`REALM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFLINE_USER_SESSION`
--

LOCK TABLES `OFFLINE_USER_SESSION` WRITE;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFLINE_USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORG`
--

DROP TABLE IF EXISTS `ORG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORG` (
  `ID` varchar(255) NOT NULL,
  `ENABLED` tinyint NOT NULL,
  `REALM_ID` varchar(255) NOT NULL,
  `GROUP_ID` varchar(255) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` text,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_ORG_NAME` (`REALM_ID`,`NAME`),
  UNIQUE KEY `UK_ORG_GROUP` (`GROUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORG`
--

LOCK TABLES `ORG` WRITE;
/*!40000 ALTER TABLE `ORG` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ORG_DOMAIN`
--

DROP TABLE IF EXISTS `ORG_DOMAIN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ORG_DOMAIN` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VERIFIED` tinyint NOT NULL,
  `ORG_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORG_DOMAIN`
--

LOCK TABLES `ORG_DOMAIN` WRITE;
/*!40000 ALTER TABLE `ORG_DOMAIN` DISABLE KEYS */;
/*!40000 ALTER TABLE `ORG_DOMAIN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `POLICY_CONFIG`
--

DROP TABLE IF EXISTS `POLICY_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `POLICY_CONFIG` (
  `POLICY_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` longtext,
  PRIMARY KEY (`POLICY_ID`,`NAME`),
  CONSTRAINT `FKDC34197CF864C4E43` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `POLICY_CONFIG`
--

LOCK TABLES `POLICY_CONFIG` WRITE;
/*!40000 ALTER TABLE `POLICY_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `POLICY_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROTOCOL_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `PROTOCOL` varchar(255) NOT NULL,
  `PROTOCOL_MAPPER_NAME` varchar(255) NOT NULL,
  `CLIENT_ID` varchar(36) DEFAULT NULL,
  `CLIENT_SCOPE_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_PROTOCOL_MAPPER_CLIENT` (`CLIENT_ID`),
  KEY `IDX_CLSCOPE_PROTMAP` (`CLIENT_SCOPE_ID`),
  CONSTRAINT `FK_CLI_SCOPE_MAPPER` FOREIGN KEY (`CLIENT_SCOPE_ID`) REFERENCES `CLIENT_SCOPE` (`ID`),
  CONSTRAINT `FK_PCM_REALM` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER`
--

LOCK TABLES `PROTOCOL_MAPPER` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER` VALUES ('002d53c6-9555-4112-9729-ab8379b977e1','email','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ba5a618d-eb38-4b3d-89f0-930d25469cb7'),('04e8d0ca-8822-467c-9948-f561d3c03609','audience resolve','openid-connect','oidc-audience-resolve-mapper','2fb2e693-63d5-46cf-a8cc-f1f36e1418d6',NULL),('06d74897-45f9-4a37-89b8-dbe619dcf702','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('0a3a1844-c972-4640-a626-16ad65b71394','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'91deb1f1-3467-4a17-9bdc-cc27a9cefbb5'),('0cbaa64c-ccfa-4bd8-9f81-b2153ec91335','acr loa level','openid-connect','oidc-acr-mapper',NULL,'4e6cc391-6c83-49b0-9d81-cba74e0a48ea'),('0e2fb2b6-9171-41e9-9644-59c0e0dd0fbf','upn','openid-connect','oidc-usermodel-attribute-mapper',NULL,'26ad2e0f-2858-4708-9f0e-b36ef5957ab5'),('17ac42c6-b0eb-494f-aa08-08ab448a3e81','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('2393e7c5-1ca9-4531-ab11-917a83ea0a02','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('24473407-2d94-4f4e-977d-2fefe346273d','role list','saml','saml-role-list-mapper',NULL,'0009537e-c0b6-42d2-bc03-0f444c1c2774'),('271b44fc-9f37-45aa-bed4-3a333425e64c','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'68a14bef-30aa-4c9a-b2df-2d872039e915'),('2859cfd2-c554-4d6a-a541-15969a23cee1','address','openid-connect','oidc-address-mapper',NULL,'095e48a0-40c6-47c0-b438-2b3baa2acb37'),('294ed86f-2007-475f-b679-7b0cabd0f271','email','openid-connect','oidc-usermodel-attribute-mapper',NULL,'91deb1f1-3467-4a17-9bdc-cc27a9cefbb5'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','address','openid-connect','oidc-address-mapper',NULL,'a927d35f-5ba7-43ef-aebd-99b06490882f'),('2e13e665-88a8-4365-ad87-9143e42b26ac','sub','openid-connect','oidc-sub-mapper',NULL,'a47ac21b-c943-4367-b439-05d79ab4b602'),('3168d65e-de52-455f-9589-3c42c4fa22a4','given name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('316e3da7-54e4-4604-a750-fbb49b07f2fd','acr loa level','openid-connect','oidc-acr-mapper',NULL,'947d8eb2-d905-4564-8524-245ec1c97604'),('33a2f9ed-0013-406b-85d8-6464a827a9f9','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('33b5958f-388b-43c8-884b-1135552b0f92','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'f0296697-946e-456e-b265-7c36b92726e7'),('37609903-941b-4c4b-be38-91010fb044b8','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'a9d8695b-ba1a-448c-aa44-0b2665231af0'),('3768b0c3-e3f1-446c-a6d8-09e5ebe84dee','audience resolve','openid-connect','oidc-audience-resolve-mapper','a30d47d0-c3ae-4592-a804-aafcd3cbc81d',NULL),('3e4c4d80-ebd3-409b-82ae-b99094bfa56f','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('3e9b7605-b189-4cdc-9bce-7f216a79012c','username','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('4228a133-9497-4a07-b32e-0c60ad27f95f','family name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('46d7c942-9ead-48f3-a0ba-524780b8614b','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('46e4454d-34b5-4ff6-a96a-03e867914663','city','openid-connect','oidc-usermodel-attribute-mapper',NULL,'a6fcc2db-5e24-4ebf-baa6-142bf1e18d26'),('49f3a005-46a6-4b5e-93cb-cbafbc097ce7','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'87b0ace7-ebb0-4465-94ab-6f8f993a234a'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','city','openid-connect','oidc-usermodel-attribute-mapper','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',NULL),('4ff4175a-6a88-4a51-b8c8-ed8afcdb52d4','picture','openid-connect','oidc-usermodel-attribute-mapper','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',NULL),('526a5e42-90e4-4ac4-9282-1b266d1019d4','given name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('5337836f-c2c6-4028-aeca-275e9f213de6','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('554a00f9-e58c-4eaa-ba4d-31ed8ec4f445','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'a9d8695b-ba1a-448c-aa44-0b2665231af0'),('56784b49-223d-4c6d-95a7-2064ea4eecf1','role list','saml','saml-role-list-mapper',NULL,'fdc515e3-b32a-422e-ab97-21e20521dc15'),('59ff9202-bd3e-4992-b6dc-f349b185335c','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('6082fd27-2158-4164-9293-07fa10715d45','family name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('645ff205-f591-44cc-9395-bb6955034900','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'49009358-8fa1-4996-b77a-179509d8edfc'),('66431a9a-73f7-42d2-a70f-5c922b0a5a81','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('686f4dbd-6777-4d21-b13c-1bbbf67f332a','username','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('69c16b99-ad07-4e99-a0f0-8bca83e7ef77','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'1ae55ce0-138f-491e-8f40-d72f2cde4590'),('6b1e3d4f-50d6-43a2-b08b-00cb73c01eb4','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449'),('6d463e95-549b-4b2c-8922-f4f8eadc16b1','locale','openid-connect','oidc-usermodel-attribute-mapper','56e41688-ad77-45be-9ea5-5feeebdd496e',NULL),('6e07b776-4f5d-4259-8f16-a3f25cd457f1','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('6ff6239c-d5e0-4ea9-a9e9-73fb2d22842d','locale','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('713360a7-d4f2-47d5-9e43-bec4e725cf68','auth_time','openid-connect','oidc-usersessionmodel-note-mapper',NULL,'08cc9784-abae-4222-b79c-a29c1c80d32f'),('73f9934d-1b34-4f61-bfa8-9a393eb9a67a','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('768b0409-554e-4a5e-b5c0-05d443db3c3d','full name','openid-connect','oidc-full-name-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','address','openid-connect','oidc-address-mapper',NULL,'226c15bb-33ef-4845-931d-27f03df6d065'),('794b8abd-136c-467d-bf3e-1addcc3307ea','locale','openid-connect','oidc-usermodel-attribute-mapper','45eab072-6c16-4ce9-895e-b8b1567fbb1c',NULL),('799c5ecc-b3c8-4b89-b4b0-7f2838b565a0','country','openid-connect','oidc-usermodel-attribute-mapper',NULL,'a6fcc2db-5e24-4ebf-baa6-142bf1e18d26'),('79f228d7-2966-49c2-a484-07add63d8f98','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'26ad2e0f-2858-4708-9f0e-b36ef5957ab5'),('7a43b0e5-6a11-4568-a23c-51578aa9f007','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'ba5a618d-eb38-4b3d-89f0-930d25469cb7'),('7b3bee43-56b0-4e52-864c-7c1536d40b3c','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('7dada189-8819-4ae1-8992-eea9146d868d','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449'),('80c2cf29-2958-4b4c-8780-28da2fad69e4','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'87b0ace7-ebb0-4465-94ab-6f8f993a234a'),('8430c3a2-c4ed-41dd-800f-fc354aad969b','sub','openid-connect','oidc-sub-mapper',NULL,'08cc9784-abae-4222-b79c-a29c1c80d32f'),('84675e95-c9ff-43c5-8327-8f8f82e51780','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('87690eb5-176c-4e91-bd29-dcea04ac72bc','audience resolve','openid-connect','oidc-audience-resolve-mapper','d994103a-c761-49e1-83cd-8dd421412620',NULL),('87c81b36-01a4-4dc1-b07a-e69a5d291962','birthdate','openid-connect','oidc-usermodel-attribute-mapper','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',NULL),('8925e39a-673b-47d7-993b-0ab594cd6d14','profile','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('8badf02f-e1d9-4195-8de2-ca7b9af51b45','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('90df3fcb-cb42-4b4c-bbc2-686f55332faa','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('97241d60-3477-4802-b86c-78eb2b28ce83','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'c2c7d4fc-6967-49ad-ba95-1cc64bee1b99'),('98e8cbac-773d-42c3-9492-6cb5d59dee9e','auth_time','openid-connect','oidc-usersessionmodel-note-mapper',NULL,'a47ac21b-c943-4367-b439-05d79ab4b602'),('9a3f3a02-daba-4efd-9ae6-b67f1b9c4058','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('9cc23318-c49b-4c78-9dce-069615dea4cd','full name','openid-connect','oidc-full-name-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('a32843f2-4671-4037-952d-3f0492f41620','allowed web origins','openid-connect','oidc-allowed-origins-mapper',NULL,'6617ecae-8bd4-412f-8458-4f9f19cebd63'),('a47a51d7-e038-41c2-9342-9dc6871c35dd','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'49009358-8fa1-4996-b77a-179509d8edfc'),('a95fd805-8e80-4603-8285-32d4ed4244d6','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'f0296697-946e-456e-b265-7c36b92726e7'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','phone number','openid-connect','oidc-usermodel-attribute-mapper','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',NULL),('abeebcf6-7010-44a1-bfd5-98ad62f64f4f','nickname','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('afc98f8f-bf80-4400-b63a-865f8920c67b','website','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('b056c7c3-0492-4b90-8843-afbe37fde4f4','auth_time','openid-connect','oidc-usersessionmodel-note-mapper',NULL,'dc4f4018-0584-4f37-964d-eca9cc2aa99d'),('b513d173-09d2-4722-9fb1-8f335265ec25','locale','openid-connect','oidc-usermodel-attribute-mapper','565a59c8-7ca2-47eb-b2a4-23ca31d10617',NULL),('b9412f18-0692-4be4-bf8c-84c1285308bb','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('bd547a60-2388-49be-9dfb-f515da7413cb','gender','openid-connect','oidc-usermodel-attribute-mapper','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',NULL),('c35e7dd1-7350-4721-b1db-93d3e870ac18','zoneinfo','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('c73c7369-514a-4b1c-86d2-919ca457c03e','acr loa level','openid-connect','oidc-acr-mapper',NULL,'ae5179e3-c137-4211-9a53-4c4e72f2096a'),('c924513c-17e7-4668-a31e-d28f3f9f217b','country','openid-connect','oidc-usermodel-attribute-mapper','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',NULL),('ccd259ef-ffae-4c06-8bc6-24ca779bf56a','given name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('cdc9038a-d348-490e-a1db-68e69941731d','postalCode','openid-connect','oidc-usermodel-attribute-mapper',NULL,'a6fcc2db-5e24-4ebf-baa6-142bf1e18d26'),('cf7c508c-2a1c-4ae6-b7d2-d2dee46cb952','sub','openid-connect','oidc-sub-mapper',NULL,'dc4f4018-0584-4f37-964d-eca9cc2aa99d'),('d051ad1e-35c6-4b1f-99f8-7596c104d5b1','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('d2b00fab-6fb6-43f1-a6b7-5211d82d8676','phone number verified','openid-connect','oidc-usermodel-attribute-mapper',NULL,'34668ee5-d79f-4b1c-8116-44ace66dfdeb'),('d66f00f5-763d-49fc-a481-7cbfa3693c37','client roles','openid-connect','oidc-usermodel-client-role-mapper',NULL,'a9d8695b-ba1a-448c-aa44-0b2665231af0'),('d69ad0a9-b975-40b8-ad8f-5c0cad32ec4e','middle name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('d6a5ac91-5aaf-466a-9930-7f76ad66658b','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('d823944e-362b-4a3c-8b47-f5bc94fe4742','picture','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('dca01981-3f5d-4a16-929c-6414bc37a7b9','family name','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('dd5e9cd7-006c-4d46-b1d7-66141213fdef','phone number','openid-connect','oidc-usermodel-attribute-mapper',NULL,'34668ee5-d79f-4b1c-8116-44ace66dfdeb'),('dfe28f18-eb70-4ced-b708-48f6325362f4','audience resolve','openid-connect','oidc-audience-resolve-mapper',NULL,'49009358-8fa1-4996-b77a-179509d8edfc'),('e111805a-623d-4699-af88-ea0db3b2a89b','birthdate','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3'),('e3c44cd1-b231-4611-885e-7b6eb0182b84','email','openid-connect','oidc-usermodel-attribute-mapper',NULL,'3faf99cf-6f15-430a-bb1b-82cb86e2a5df'),('e5e82ee1-bffb-44d9-95b3-e4a4b3c74b48','full name','openid-connect','oidc-full-name-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('e9bac6c5-94d3-432c-b8d7-d136473f7ae4','upn','openid-connect','oidc-usermodel-attribute-mapper',NULL,'a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2'),('ebc8c0d9-448c-4d0e-9c87-7a245b51fa77','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('eda27655-fad2-4d6a-8102-9182d3ae8a61','realm roles','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'2bb86f9f-3cbd-4a99-a9f2-1a7222bb8449'),('ee39c80c-4d4b-4e40-9263-a5e360589adf','groups','openid-connect','oidc-usermodel-realm-role-mapper',NULL,'a30b4e19-bdbc-4e1d-a15c-55bd99b0ffa2'),('ee972c58-9040-44e7-a8ab-53ce904f9058','postalCode','openid-connect','oidc-usermodel-attribute-mapper','a0b15bbe-0ab7-4f99-8f51-5f39d62de58f',NULL),('ef23b018-d4cf-49ba-b99a-b58a86c7b8fe','role list','saml','saml-role-list-mapper',NULL,'e52eb992-13f7-4886-a3b7-0e3df3a4e338'),('f440fe9b-cde3-4cac-99f7-ac57f981e19f','username','openid-connect','oidc-usermodel-attribute-mapper',NULL,'66701909-f2ee-4c19-b5c9-b0375978d11d'),('f4676828-d750-4341-9d0b-f63b9bd7aaf9','email verified','openid-connect','oidc-usermodel-property-mapper',NULL,'3faf99cf-6f15-430a-bb1b-82cb86e2a5df'),('f50da57c-f998-4267-b8a8-417c4e6acf4f','gender','openid-connect','oidc-usermodel-attribute-mapper',NULL,'d4d1d2e6-8020-4b4f-ace9-a7ac06e435ce'),('f749a70c-38e8-4830-922f-05e40c19eeaf','upn','openid-connect','oidc-usermodel-attribute-mapper',NULL,'c2c7d4fc-6967-49ad-ba95-1cc64bee1b99'),('fb6d94ba-2809-4f63-a95c-d84b3565df79','updated at','openid-connect','oidc-usermodel-attribute-mapper',NULL,'ed5b1eef-f394-4ece-8a6e-3e3a8c800ca3');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROTOCOL_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `PROTOCOL_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROTOCOL_MAPPER_CONFIG` (
  `PROTOCOL_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`PROTOCOL_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_PMCONFIG` FOREIGN KEY (`PROTOCOL_MAPPER_ID`) REFERENCES `PROTOCOL_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROTOCOL_MAPPER_CONFIG`
--

LOCK TABLES `PROTOCOL_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` DISABLE KEYS */;
INSERT INTO `PROTOCOL_MAPPER_CONFIG` VALUES ('002d53c6-9555-4112-9729-ab8379b977e1','true','access.token.claim'),('002d53c6-9555-4112-9729-ab8379b977e1','email','claim.name'),('002d53c6-9555-4112-9729-ab8379b977e1','true','id.token.claim'),('002d53c6-9555-4112-9729-ab8379b977e1','true','introspection.token.claim'),('002d53c6-9555-4112-9729-ab8379b977e1','String','jsonType.label'),('002d53c6-9555-4112-9729-ab8379b977e1','email','user.attribute'),('002d53c6-9555-4112-9729-ab8379b977e1','true','userinfo.token.claim'),('06d74897-45f9-4a37-89b8-dbe619dcf702','true','access.token.claim'),('06d74897-45f9-4a37-89b8-dbe619dcf702','picture','claim.name'),('06d74897-45f9-4a37-89b8-dbe619dcf702','true','id.token.claim'),('06d74897-45f9-4a37-89b8-dbe619dcf702','true','introspection.token.claim'),('06d74897-45f9-4a37-89b8-dbe619dcf702','String','jsonType.label'),('06d74897-45f9-4a37-89b8-dbe619dcf702','picture','user.attribute'),('06d74897-45f9-4a37-89b8-dbe619dcf702','true','userinfo.token.claim'),('0a3a1844-c972-4640-a626-16ad65b71394','true','access.token.claim'),('0a3a1844-c972-4640-a626-16ad65b71394','email_verified','claim.name'),('0a3a1844-c972-4640-a626-16ad65b71394','true','id.token.claim'),('0a3a1844-c972-4640-a626-16ad65b71394','true','introspection.token.claim'),('0a3a1844-c972-4640-a626-16ad65b71394','boolean','jsonType.label'),('0a3a1844-c972-4640-a626-16ad65b71394','emailVerified','user.attribute'),('0a3a1844-c972-4640-a626-16ad65b71394','true','userinfo.token.claim'),('0cbaa64c-ccfa-4bd8-9f81-b2153ec91335','true','access.token.claim'),('0cbaa64c-ccfa-4bd8-9f81-b2153ec91335','true','id.token.claim'),('0cbaa64c-ccfa-4bd8-9f81-b2153ec91335','true','introspection.token.claim'),('0cbaa64c-ccfa-4bd8-9f81-b2153ec91335','true','userinfo.token.claim'),('0e2fb2b6-9171-41e9-9644-59c0e0dd0fbf','true','access.token.claim'),('0e2fb2b6-9171-41e9-9644-59c0e0dd0fbf','upn','claim.name'),('0e2fb2b6-9171-41e9-9644-59c0e0dd0fbf','true','id.token.claim'),('0e2fb2b6-9171-41e9-9644-59c0e0dd0fbf','true','introspection.token.claim'),('0e2fb2b6-9171-41e9-9644-59c0e0dd0fbf','String','jsonType.label'),('0e2fb2b6-9171-41e9-9644-59c0e0dd0fbf','username','user.attribute'),('0e2fb2b6-9171-41e9-9644-59c0e0dd0fbf','true','userinfo.token.claim'),('17ac42c6-b0eb-494f-aa08-08ab448a3e81','true','access.token.claim'),('17ac42c6-b0eb-494f-aa08-08ab448a3e81','gender','claim.name'),('17ac42c6-b0eb-494f-aa08-08ab448a3e81','true','id.token.claim'),('17ac42c6-b0eb-494f-aa08-08ab448a3e81','true','introspection.token.claim'),('17ac42c6-b0eb-494f-aa08-08ab448a3e81','String','jsonType.label'),('17ac42c6-b0eb-494f-aa08-08ab448a3e81','gender','user.attribute'),('17ac42c6-b0eb-494f-aa08-08ab448a3e81','true','userinfo.token.claim'),('2393e7c5-1ca9-4531-ab11-917a83ea0a02','true','access.token.claim'),('2393e7c5-1ca9-4531-ab11-917a83ea0a02','website','claim.name'),('2393e7c5-1ca9-4531-ab11-917a83ea0a02','true','id.token.claim'),('2393e7c5-1ca9-4531-ab11-917a83ea0a02','true','introspection.token.claim'),('2393e7c5-1ca9-4531-ab11-917a83ea0a02','String','jsonType.label'),('2393e7c5-1ca9-4531-ab11-917a83ea0a02','website','user.attribute'),('2393e7c5-1ca9-4531-ab11-917a83ea0a02','true','userinfo.token.claim'),('24473407-2d94-4f4e-977d-2fefe346273d','Role','attribute.name'),('24473407-2d94-4f4e-977d-2fefe346273d','Basic','attribute.nameformat'),('24473407-2d94-4f4e-977d-2fefe346273d','false','single'),('271b44fc-9f37-45aa-bed4-3a333425e64c','true','access.token.claim'),('271b44fc-9f37-45aa-bed4-3a333425e64c','true','introspection.token.claim'),('2859cfd2-c554-4d6a-a541-15969a23cee1','true','access.token.claim'),('2859cfd2-c554-4d6a-a541-15969a23cee1','true','id.token.claim'),('2859cfd2-c554-4d6a-a541-15969a23cee1','true','introspection.token.claim'),('2859cfd2-c554-4d6a-a541-15969a23cee1','country','user.attribute.country'),('2859cfd2-c554-4d6a-a541-15969a23cee1','formatted','user.attribute.formatted'),('2859cfd2-c554-4d6a-a541-15969a23cee1','locality','user.attribute.locality'),('2859cfd2-c554-4d6a-a541-15969a23cee1','postal_code','user.attribute.postal_code'),('2859cfd2-c554-4d6a-a541-15969a23cee1','region','user.attribute.region'),('2859cfd2-c554-4d6a-a541-15969a23cee1','street','user.attribute.street'),('2859cfd2-c554-4d6a-a541-15969a23cee1','true','userinfo.token.claim'),('294ed86f-2007-475f-b679-7b0cabd0f271','true','access.token.claim'),('294ed86f-2007-475f-b679-7b0cabd0f271','email','claim.name'),('294ed86f-2007-475f-b679-7b0cabd0f271','true','id.token.claim'),('294ed86f-2007-475f-b679-7b0cabd0f271','true','introspection.token.claim'),('294ed86f-2007-475f-b679-7b0cabd0f271','String','jsonType.label'),('294ed86f-2007-475f-b679-7b0cabd0f271','email','user.attribute'),('294ed86f-2007-475f-b679-7b0cabd0f271','true','userinfo.token.claim'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','true','access.token.claim'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','true','id.token.claim'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','true','introspection.token.claim'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','country','user.attribute.country'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','formatted','user.attribute.formatted'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','locality','user.attribute.locality'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','postal_code','user.attribute.postal_code'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','region','user.attribute.region'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','street','user.attribute.street'),('2bc98cb3-63b2-4ce1-982e-e03de89e270d','true','userinfo.token.claim'),('2e13e665-88a8-4365-ad87-9143e42b26ac','true','access.token.claim'),('2e13e665-88a8-4365-ad87-9143e42b26ac','true','introspection.token.claim'),('3168d65e-de52-455f-9589-3c42c4fa22a4','true','access.token.claim'),('3168d65e-de52-455f-9589-3c42c4fa22a4','given_name','claim.name'),('3168d65e-de52-455f-9589-3c42c4fa22a4','true','id.token.claim'),('3168d65e-de52-455f-9589-3c42c4fa22a4','true','introspection.token.claim'),('3168d65e-de52-455f-9589-3c42c4fa22a4','String','jsonType.label'),('3168d65e-de52-455f-9589-3c42c4fa22a4','firstName','user.attribute'),('3168d65e-de52-455f-9589-3c42c4fa22a4','true','userinfo.token.claim'),('316e3da7-54e4-4604-a750-fbb49b07f2fd','true','access.token.claim'),('316e3da7-54e4-4604-a750-fbb49b07f2fd','true','id.token.claim'),('316e3da7-54e4-4604-a750-fbb49b07f2fd','true','introspection.token.claim'),('33a2f9ed-0013-406b-85d8-6464a827a9f9','true','access.token.claim'),('33a2f9ed-0013-406b-85d8-6464a827a9f9','nickname','claim.name'),('33a2f9ed-0013-406b-85d8-6464a827a9f9','true','id.token.claim'),('33a2f9ed-0013-406b-85d8-6464a827a9f9','true','introspection.token.claim'),('33a2f9ed-0013-406b-85d8-6464a827a9f9','String','jsonType.label'),('33a2f9ed-0013-406b-85d8-6464a827a9f9','nickname','user.attribute'),('33a2f9ed-0013-406b-85d8-6464a827a9f9','true','userinfo.token.claim'),('33b5958f-388b-43c8-884b-1135552b0f92','true','access.token.claim'),('33b5958f-388b-43c8-884b-1135552b0f92','phone_number_verified','claim.name'),('33b5958f-388b-43c8-884b-1135552b0f92','true','id.token.claim'),('33b5958f-388b-43c8-884b-1135552b0f92','true','introspection.token.claim'),('33b5958f-388b-43c8-884b-1135552b0f92','boolean','jsonType.label'),('33b5958f-388b-43c8-884b-1135552b0f92','phoneNumberVerified','user.attribute'),('33b5958f-388b-43c8-884b-1135552b0f92','true','userinfo.token.claim'),('37609903-941b-4c4b-be38-91010fb044b8','true','access.token.claim'),('37609903-941b-4c4b-be38-91010fb044b8','realm_access.roles','claim.name'),('37609903-941b-4c4b-be38-91010fb044b8','true','introspection.token.claim'),('37609903-941b-4c4b-be38-91010fb044b8','String','jsonType.label'),('37609903-941b-4c4b-be38-91010fb044b8','true','multivalued'),('37609903-941b-4c4b-be38-91010fb044b8','foo','user.attribute'),('3e4c4d80-ebd3-409b-82ae-b99094bfa56f','true','access.token.claim'),('3e4c4d80-ebd3-409b-82ae-b99094bfa56f','locale','claim.name'),('3e4c4d80-ebd3-409b-82ae-b99094bfa56f','true','id.token.claim'),('3e4c4d80-ebd3-409b-82ae-b99094bfa56f','true','introspection.token.claim'),('3e4c4d80-ebd3-409b-82ae-b99094bfa56f','String','jsonType.label'),('3e4c4d80-ebd3-409b-82ae-b99094bfa56f','locale','user.attribute'),('3e4c4d80-ebd3-409b-82ae-b99094bfa56f','true','userinfo.token.claim'),('3e9b7605-b189-4cdc-9bce-7f216a79012c','true','access.token.claim'),('3e9b7605-b189-4cdc-9bce-7f216a79012c','preferred_username','claim.name'),('3e9b7605-b189-4cdc-9bce-7f216a79012c','true','id.token.claim'),('3e9b7605-b189-4cdc-9bce-7f216a79012c','true','introspection.token.claim'),('3e9b7605-b189-4cdc-9bce-7f216a79012c','String','jsonType.label'),('3e9b7605-b189-4cdc-9bce-7f216a79012c','username','user.attribute'),('3e9b7605-b189-4cdc-9bce-7f216a79012c','true','userinfo.token.claim'),('4228a133-9497-4a07-b32e-0c60ad27f95f','true','access.token.claim'),('4228a133-9497-4a07-b32e-0c60ad27f95f','family_name','claim.name'),('4228a133-9497-4a07-b32e-0c60ad27f95f','true','id.token.claim'),('4228a133-9497-4a07-b32e-0c60ad27f95f','true','introspection.token.claim'),('4228a133-9497-4a07-b32e-0c60ad27f95f','String','jsonType.label'),('4228a133-9497-4a07-b32e-0c60ad27f95f','lastName','user.attribute'),('4228a133-9497-4a07-b32e-0c60ad27f95f','true','userinfo.token.claim'),('46d7c942-9ead-48f3-a0ba-524780b8614b','true','access.token.claim'),('46d7c942-9ead-48f3-a0ba-524780b8614b','locale','claim.name'),('46d7c942-9ead-48f3-a0ba-524780b8614b','true','id.token.claim'),('46d7c942-9ead-48f3-a0ba-524780b8614b','true','introspection.token.claim'),('46d7c942-9ead-48f3-a0ba-524780b8614b','String','jsonType.label'),('46d7c942-9ead-48f3-a0ba-524780b8614b','locale','user.attribute'),('46d7c942-9ead-48f3-a0ba-524780b8614b','true','userinfo.token.claim'),('46e4454d-34b5-4ff6-a96a-03e867914663','true','access.token.claim'),('46e4454d-34b5-4ff6-a96a-03e867914663','true','id.token.claim'),('46e4454d-34b5-4ff6-a96a-03e867914663','true','introspection.token.claim'),('46e4454d-34b5-4ff6-a96a-03e867914663','String','jsonType.label'),('46e4454d-34b5-4ff6-a96a-03e867914663','false','lightweight.claim'),('46e4454d-34b5-4ff6-a96a-03e867914663','city','user.attribute'),('46e4454d-34b5-4ff6-a96a-03e867914663','true','userinfo.token.claim'),('49f3a005-46a6-4b5e-93cb-cbafbc097ce7','true','access.token.claim'),('49f3a005-46a6-4b5e-93cb-cbafbc097ce7','phone_number_verified','claim.name'),('49f3a005-46a6-4b5e-93cb-cbafbc097ce7','true','id.token.claim'),('49f3a005-46a6-4b5e-93cb-cbafbc097ce7','true','introspection.token.claim'),('49f3a005-46a6-4b5e-93cb-cbafbc097ce7','boolean','jsonType.label'),('49f3a005-46a6-4b5e-93cb-cbafbc097ce7','phoneNumberVerified','user.attribute'),('49f3a005-46a6-4b5e-93cb-cbafbc097ce7','true','userinfo.token.claim'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','true','access.token.claim'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','city','claim.name'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','true','id.token.claim'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','true','introspection.token.claim'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','String','jsonType.label'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','false','lightweight.claim'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','city','user.attribute'),('4cdd1f4e-dc3c-4d77-ba60-5f477e7ff0d6','true','userinfo.token.claim'),('4ff4175a-6a88-4a51-b8c8-ed8afcdb52d4','true','access.token.claim'),('4ff4175a-6a88-4a51-b8c8-ed8afcdb52d4','picture','claim.name'),('4ff4175a-6a88-4a51-b8c8-ed8afcdb52d4','true','id.token.claim'),('4ff4175a-6a88-4a51-b8c8-ed8afcdb52d4','true','introspection.token.claim'),('4ff4175a-6a88-4a51-b8c8-ed8afcdb52d4','String','jsonType.label'),('4ff4175a-6a88-4a51-b8c8-ed8afcdb52d4','picture','user.attribute'),('4ff4175a-6a88-4a51-b8c8-ed8afcdb52d4','true','userinfo.token.claim'),('526a5e42-90e4-4ac4-9282-1b266d1019d4','true','access.token.claim'),('526a5e42-90e4-4ac4-9282-1b266d1019d4','given_name','claim.name'),('526a5e42-90e4-4ac4-9282-1b266d1019d4','true','id.token.claim'),('526a5e42-90e4-4ac4-9282-1b266d1019d4','true','introspection.token.claim'),('526a5e42-90e4-4ac4-9282-1b266d1019d4','String','jsonType.label'),('526a5e42-90e4-4ac4-9282-1b266d1019d4','firstName','user.attribute'),('526a5e42-90e4-4ac4-9282-1b266d1019d4','true','userinfo.token.claim'),('5337836f-c2c6-4028-aeca-275e9f213de6','true','access.token.claim'),('5337836f-c2c6-4028-aeca-275e9f213de6','gender','claim.name'),('5337836f-c2c6-4028-aeca-275e9f213de6','true','id.token.claim'),('5337836f-c2c6-4028-aeca-275e9f213de6','true','introspection.token.claim'),('5337836f-c2c6-4028-aeca-275e9f213de6','String','jsonType.label'),('5337836f-c2c6-4028-aeca-275e9f213de6','gender','user.attribute'),('5337836f-c2c6-4028-aeca-275e9f213de6','true','userinfo.token.claim'),('554a00f9-e58c-4eaa-ba4d-31ed8ec4f445','true','access.token.claim'),('554a00f9-e58c-4eaa-ba4d-31ed8ec4f445','true','introspection.token.claim'),('56784b49-223d-4c6d-95a7-2064ea4eecf1','Role','attribute.name'),('56784b49-223d-4c6d-95a7-2064ea4eecf1','Basic','attribute.nameformat'),('56784b49-223d-4c6d-95a7-2064ea4eecf1','false','single'),('59ff9202-bd3e-4992-b6dc-f349b185335c','true','access.token.claim'),('59ff9202-bd3e-4992-b6dc-f349b185335c','picture','claim.name'),('59ff9202-bd3e-4992-b6dc-f349b185335c','true','id.token.claim'),('59ff9202-bd3e-4992-b6dc-f349b185335c','true','introspection.token.claim'),('59ff9202-bd3e-4992-b6dc-f349b185335c','String','jsonType.label'),('59ff9202-bd3e-4992-b6dc-f349b185335c','picture','user.attribute'),('59ff9202-bd3e-4992-b6dc-f349b185335c','true','userinfo.token.claim'),('6082fd27-2158-4164-9293-07fa10715d45','true','access.token.claim'),('6082fd27-2158-4164-9293-07fa10715d45','family_name','claim.name'),('6082fd27-2158-4164-9293-07fa10715d45','true','id.token.claim'),('6082fd27-2158-4164-9293-07fa10715d45','true','introspection.token.claim'),('6082fd27-2158-4164-9293-07fa10715d45','String','jsonType.label'),('6082fd27-2158-4164-9293-07fa10715d45','lastName','user.attribute'),('6082fd27-2158-4164-9293-07fa10715d45','true','userinfo.token.claim'),('645ff205-f591-44cc-9395-bb6955034900','true','access.token.claim'),('645ff205-f591-44cc-9395-bb6955034900','realm_access.roles','claim.name'),('645ff205-f591-44cc-9395-bb6955034900','true','introspection.token.claim'),('645ff205-f591-44cc-9395-bb6955034900','String','jsonType.label'),('645ff205-f591-44cc-9395-bb6955034900','true','multivalued'),('645ff205-f591-44cc-9395-bb6955034900','foo','user.attribute'),('66431a9a-73f7-42d2-a70f-5c922b0a5a81','true','access.token.claim'),('66431a9a-73f7-42d2-a70f-5c922b0a5a81','middle_name','claim.name'),('66431a9a-73f7-42d2-a70f-5c922b0a5a81','true','id.token.claim'),('66431a9a-73f7-42d2-a70f-5c922b0a5a81','true','introspection.token.claim'),('66431a9a-73f7-42d2-a70f-5c922b0a5a81','String','jsonType.label'),('66431a9a-73f7-42d2-a70f-5c922b0a5a81','middleName','user.attribute'),('66431a9a-73f7-42d2-a70f-5c922b0a5a81','true','userinfo.token.claim'),('686f4dbd-6777-4d21-b13c-1bbbf67f332a','true','access.token.claim'),('686f4dbd-6777-4d21-b13c-1bbbf67f332a','preferred_username','claim.name'),('686f4dbd-6777-4d21-b13c-1bbbf67f332a','true','id.token.claim'),('686f4dbd-6777-4d21-b13c-1bbbf67f332a','true','introspection.token.claim'),('686f4dbd-6777-4d21-b13c-1bbbf67f332a','String','jsonType.label'),('686f4dbd-6777-4d21-b13c-1bbbf67f332a','username','user.attribute'),('686f4dbd-6777-4d21-b13c-1bbbf67f332a','true','userinfo.token.claim'),('69c16b99-ad07-4e99-a0f0-8bca83e7ef77','true','access.token.claim'),('69c16b99-ad07-4e99-a0f0-8bca83e7ef77','true','introspection.token.claim'),('6b1e3d4f-50d6-43a2-b08b-00cb73c01eb4','true','access.token.claim'),('6b1e3d4f-50d6-43a2-b08b-00cb73c01eb4','resource_access.${client_id}.roles','claim.name'),('6b1e3d4f-50d6-43a2-b08b-00cb73c01eb4','true','introspection.token.claim'),('6b1e3d4f-50d6-43a2-b08b-00cb73c01eb4','String','jsonType.label'),('6b1e3d4f-50d6-43a2-b08b-00cb73c01eb4','true','multivalued'),('6b1e3d4f-50d6-43a2-b08b-00cb73c01eb4','foo','user.attribute'),('6d463e95-549b-4b2c-8922-f4f8eadc16b1','true','access.token.claim'),('6d463e95-549b-4b2c-8922-f4f8eadc16b1','locale','claim.name'),('6d463e95-549b-4b2c-8922-f4f8eadc16b1','true','id.token.claim'),('6d463e95-549b-4b2c-8922-f4f8eadc16b1','true','introspection.token.claim'),('6d463e95-549b-4b2c-8922-f4f8eadc16b1','String','jsonType.label'),('6d463e95-549b-4b2c-8922-f4f8eadc16b1','locale','user.attribute'),('6d463e95-549b-4b2c-8922-f4f8eadc16b1','true','userinfo.token.claim'),('6e07b776-4f5d-4259-8f16-a3f25cd457f1','true','access.token.claim'),('6e07b776-4f5d-4259-8f16-a3f25cd457f1','zoneinfo','claim.name'),('6e07b776-4f5d-4259-8f16-a3f25cd457f1','true','id.token.claim'),('6e07b776-4f5d-4259-8f16-a3f25cd457f1','true','introspection.token.claim'),('6e07b776-4f5d-4259-8f16-a3f25cd457f1','String','jsonType.label'),('6e07b776-4f5d-4259-8f16-a3f25cd457f1','zoneinfo','user.attribute'),('6e07b776-4f5d-4259-8f16-a3f25cd457f1','true','userinfo.token.claim'),('6ff6239c-d5e0-4ea9-a9e9-73fb2d22842d','true','access.token.claim'),('6ff6239c-d5e0-4ea9-a9e9-73fb2d22842d','locale','claim.name'),('6ff6239c-d5e0-4ea9-a9e9-73fb2d22842d','true','id.token.claim'),('6ff6239c-d5e0-4ea9-a9e9-73fb2d22842d','true','introspection.token.claim'),('6ff6239c-d5e0-4ea9-a9e9-73fb2d22842d','String','jsonType.label'),('6ff6239c-d5e0-4ea9-a9e9-73fb2d22842d','locale','user.attribute'),('6ff6239c-d5e0-4ea9-a9e9-73fb2d22842d','true','userinfo.token.claim'),('713360a7-d4f2-47d5-9e43-bec4e725cf68','true','access.token.claim'),('713360a7-d4f2-47d5-9e43-bec4e725cf68','auth_time','claim.name'),('713360a7-d4f2-47d5-9e43-bec4e725cf68','true','id.token.claim'),('713360a7-d4f2-47d5-9e43-bec4e725cf68','true','introspection.token.claim'),('713360a7-d4f2-47d5-9e43-bec4e725cf68','long','jsonType.label'),('713360a7-d4f2-47d5-9e43-bec4e725cf68','AUTH_TIME','user.session.note'),('73f9934d-1b34-4f61-bfa8-9a393eb9a67a','true','access.token.claim'),('73f9934d-1b34-4f61-bfa8-9a393eb9a67a','birthdate','claim.name'),('73f9934d-1b34-4f61-bfa8-9a393eb9a67a','true','id.token.claim'),('73f9934d-1b34-4f61-bfa8-9a393eb9a67a','true','introspection.token.claim'),('73f9934d-1b34-4f61-bfa8-9a393eb9a67a','String','jsonType.label'),('73f9934d-1b34-4f61-bfa8-9a393eb9a67a','birthdate','user.attribute'),('73f9934d-1b34-4f61-bfa8-9a393eb9a67a','true','userinfo.token.claim'),('768b0409-554e-4a5e-b5c0-05d443db3c3d','true','access.token.claim'),('768b0409-554e-4a5e-b5c0-05d443db3c3d','true','id.token.claim'),('768b0409-554e-4a5e-b5c0-05d443db3c3d','true','introspection.token.claim'),('768b0409-554e-4a5e-b5c0-05d443db3c3d','true','userinfo.token.claim'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','true','access.token.claim'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','true','id.token.claim'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','true','introspection.token.claim'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','country','user.attribute.country'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','formatted','user.attribute.formatted'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','locality','user.attribute.locality'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','postal_code','user.attribute.postal_code'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','region','user.attribute.region'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','street','user.attribute.street'),('76e953f2-a3fc-4383-826e-47ab6f17b48b','true','userinfo.token.claim'),('794b8abd-136c-467d-bf3e-1addcc3307ea','true','access.token.claim'),('794b8abd-136c-467d-bf3e-1addcc3307ea','locale','claim.name'),('794b8abd-136c-467d-bf3e-1addcc3307ea','true','id.token.claim'),('794b8abd-136c-467d-bf3e-1addcc3307ea','true','introspection.token.claim'),('794b8abd-136c-467d-bf3e-1addcc3307ea','String','jsonType.label'),('794b8abd-136c-467d-bf3e-1addcc3307ea','locale','user.attribute'),('794b8abd-136c-467d-bf3e-1addcc3307ea','true','userinfo.token.claim'),('799c5ecc-b3c8-4b89-b4b0-7f2838b565a0','true','access.token.claim'),('799c5ecc-b3c8-4b89-b4b0-7f2838b565a0','true','id.token.claim'),('799c5ecc-b3c8-4b89-b4b0-7f2838b565a0','true','introspection.token.claim'),('799c5ecc-b3c8-4b89-b4b0-7f2838b565a0','String','jsonType.label'),('799c5ecc-b3c8-4b89-b4b0-7f2838b565a0','false','lightweight.claim'),('799c5ecc-b3c8-4b89-b4b0-7f2838b565a0','country','user.attribute'),('799c5ecc-b3c8-4b89-b4b0-7f2838b565a0','true','userinfo.token.claim'),('79f228d7-2966-49c2-a484-07add63d8f98','true','access.token.claim'),('79f228d7-2966-49c2-a484-07add63d8f98','groups','claim.name'),('79f228d7-2966-49c2-a484-07add63d8f98','true','id.token.claim'),('79f228d7-2966-49c2-a484-07add63d8f98','true','introspection.token.claim'),('79f228d7-2966-49c2-a484-07add63d8f98','String','jsonType.label'),('79f228d7-2966-49c2-a484-07add63d8f98','true','multivalued'),('79f228d7-2966-49c2-a484-07add63d8f98','foo','user.attribute'),('7a43b0e5-6a11-4568-a23c-51578aa9f007','true','access.token.claim'),('7a43b0e5-6a11-4568-a23c-51578aa9f007','email_verified','claim.name'),('7a43b0e5-6a11-4568-a23c-51578aa9f007','true','id.token.claim'),('7a43b0e5-6a11-4568-a23c-51578aa9f007','true','introspection.token.claim'),('7a43b0e5-6a11-4568-a23c-51578aa9f007','boolean','jsonType.label'),('7a43b0e5-6a11-4568-a23c-51578aa9f007','emailVerified','user.attribute'),('7a43b0e5-6a11-4568-a23c-51578aa9f007','true','userinfo.token.claim'),('7b3bee43-56b0-4e52-864c-7c1536d40b3c','true','access.token.claim'),('7b3bee43-56b0-4e52-864c-7c1536d40b3c','profile','claim.name'),('7b3bee43-56b0-4e52-864c-7c1536d40b3c','true','id.token.claim'),('7b3bee43-56b0-4e52-864c-7c1536d40b3c','true','introspection.token.claim'),('7b3bee43-56b0-4e52-864c-7c1536d40b3c','String','jsonType.label'),('7b3bee43-56b0-4e52-864c-7c1536d40b3c','profile','user.attribute'),('7b3bee43-56b0-4e52-864c-7c1536d40b3c','true','userinfo.token.claim'),('7dada189-8819-4ae1-8992-eea9146d868d','true','access.token.claim'),('7dada189-8819-4ae1-8992-eea9146d868d','true','introspection.token.claim'),('80c2cf29-2958-4b4c-8780-28da2fad69e4','true','access.token.claim'),('80c2cf29-2958-4b4c-8780-28da2fad69e4','phone_number','claim.name'),('80c2cf29-2958-4b4c-8780-28da2fad69e4','true','id.token.claim'),('80c2cf29-2958-4b4c-8780-28da2fad69e4','true','introspection.token.claim'),('80c2cf29-2958-4b4c-8780-28da2fad69e4','String','jsonType.label'),('80c2cf29-2958-4b4c-8780-28da2fad69e4','phoneNumber','user.attribute'),('80c2cf29-2958-4b4c-8780-28da2fad69e4','true','userinfo.token.claim'),('8430c3a2-c4ed-41dd-800f-fc354aad969b','true','access.token.claim'),('8430c3a2-c4ed-41dd-800f-fc354aad969b','true','introspection.token.claim'),('84675e95-c9ff-43c5-8327-8f8f82e51780','true','access.token.claim'),('84675e95-c9ff-43c5-8327-8f8f82e51780','profile','claim.name'),('84675e95-c9ff-43c5-8327-8f8f82e51780','true','id.token.claim'),('84675e95-c9ff-43c5-8327-8f8f82e51780','true','introspection.token.claim'),('84675e95-c9ff-43c5-8327-8f8f82e51780','String','jsonType.label'),('84675e95-c9ff-43c5-8327-8f8f82e51780','profile','user.attribute'),('84675e95-c9ff-43c5-8327-8f8f82e51780','true','userinfo.token.claim'),('87c81b36-01a4-4dc1-b07a-e69a5d291962','true','access.token.claim'),('87c81b36-01a4-4dc1-b07a-e69a5d291962','birthdate','claim.name'),('87c81b36-01a4-4dc1-b07a-e69a5d291962','true','id.token.claim'),('87c81b36-01a4-4dc1-b07a-e69a5d291962','true','introspection.token.claim'),('87c81b36-01a4-4dc1-b07a-e69a5d291962','String','jsonType.label'),('87c81b36-01a4-4dc1-b07a-e69a5d291962','birthdate','user.attribute'),('87c81b36-01a4-4dc1-b07a-e69a5d291962','true','userinfo.token.claim'),('8925e39a-673b-47d7-993b-0ab594cd6d14','true','access.token.claim'),('8925e39a-673b-47d7-993b-0ab594cd6d14','profile','claim.name'),('8925e39a-673b-47d7-993b-0ab594cd6d14','true','id.token.claim'),('8925e39a-673b-47d7-993b-0ab594cd6d14','true','introspection.token.claim'),('8925e39a-673b-47d7-993b-0ab594cd6d14','String','jsonType.label'),('8925e39a-673b-47d7-993b-0ab594cd6d14','profile','user.attribute'),('8925e39a-673b-47d7-993b-0ab594cd6d14','true','userinfo.token.claim'),('8badf02f-e1d9-4195-8de2-ca7b9af51b45','true','access.token.claim'),('8badf02f-e1d9-4195-8de2-ca7b9af51b45','website','claim.name'),('8badf02f-e1d9-4195-8de2-ca7b9af51b45','true','id.token.claim'),('8badf02f-e1d9-4195-8de2-ca7b9af51b45','true','introspection.token.claim'),('8badf02f-e1d9-4195-8de2-ca7b9af51b45','String','jsonType.label'),('8badf02f-e1d9-4195-8de2-ca7b9af51b45','website','user.attribute'),('8badf02f-e1d9-4195-8de2-ca7b9af51b45','true','userinfo.token.claim'),('90df3fcb-cb42-4b4c-bbc2-686f55332faa','true','access.token.claim'),('90df3fcb-cb42-4b4c-bbc2-686f55332faa','nickname','claim.name'),('90df3fcb-cb42-4b4c-bbc2-686f55332faa','true','id.token.claim'),('90df3fcb-cb42-4b4c-bbc2-686f55332faa','true','introspection.token.claim'),('90df3fcb-cb42-4b4c-bbc2-686f55332faa','String','jsonType.label'),('90df3fcb-cb42-4b4c-bbc2-686f55332faa','nickname','user.attribute'),('90df3fcb-cb42-4b4c-bbc2-686f55332faa','true','userinfo.token.claim'),('97241d60-3477-4802-b86c-78eb2b28ce83','true','access.token.claim'),('97241d60-3477-4802-b86c-78eb2b28ce83','groups','claim.name'),('97241d60-3477-4802-b86c-78eb2b28ce83','true','id.token.claim'),('97241d60-3477-4802-b86c-78eb2b28ce83','true','introspection.token.claim'),('97241d60-3477-4802-b86c-78eb2b28ce83','String','jsonType.label'),('97241d60-3477-4802-b86c-78eb2b28ce83','true','multivalued'),('97241d60-3477-4802-b86c-78eb2b28ce83','foo','user.attribute'),('97241d60-3477-4802-b86c-78eb2b28ce83','true','userinfo.token.claim'),('98e8cbac-773d-42c3-9492-6cb5d59dee9e','true','access.token.claim'),('98e8cbac-773d-42c3-9492-6cb5d59dee9e','auth_time','claim.name'),('98e8cbac-773d-42c3-9492-6cb5d59dee9e','true','id.token.claim'),('98e8cbac-773d-42c3-9492-6cb5d59dee9e','true','introspection.token.claim'),('98e8cbac-773d-42c3-9492-6cb5d59dee9e','long','jsonType.label'),('98e8cbac-773d-42c3-9492-6cb5d59dee9e','AUTH_TIME','user.session.note'),('98e8cbac-773d-42c3-9492-6cb5d59dee9e','true','userinfo.token.claim'),('9a3f3a02-daba-4efd-9ae6-b67f1b9c4058','true','access.token.claim'),('9a3f3a02-daba-4efd-9ae6-b67f1b9c4058','zoneinfo','claim.name'),('9a3f3a02-daba-4efd-9ae6-b67f1b9c4058','true','id.token.claim'),('9a3f3a02-daba-4efd-9ae6-b67f1b9c4058','true','introspection.token.claim'),('9a3f3a02-daba-4efd-9ae6-b67f1b9c4058','String','jsonType.label'),('9a3f3a02-daba-4efd-9ae6-b67f1b9c4058','zoneinfo','user.attribute'),('9a3f3a02-daba-4efd-9ae6-b67f1b9c4058','true','userinfo.token.claim'),('9cc23318-c49b-4c78-9dce-069615dea4cd','true','access.token.claim'),('9cc23318-c49b-4c78-9dce-069615dea4cd','true','id.token.claim'),('9cc23318-c49b-4c78-9dce-069615dea4cd','true','introspection.token.claim'),('9cc23318-c49b-4c78-9dce-069615dea4cd','true','userinfo.token.claim'),('a32843f2-4671-4037-952d-3f0492f41620','true','access.token.claim'),('a32843f2-4671-4037-952d-3f0492f41620','true','introspection.token.claim'),('a47a51d7-e038-41c2-9342-9dc6871c35dd','true','access.token.claim'),('a47a51d7-e038-41c2-9342-9dc6871c35dd','resource_access.${client_id}.roles','claim.name'),('a47a51d7-e038-41c2-9342-9dc6871c35dd','true','introspection.token.claim'),('a47a51d7-e038-41c2-9342-9dc6871c35dd','String','jsonType.label'),('a47a51d7-e038-41c2-9342-9dc6871c35dd','true','multivalued'),('a47a51d7-e038-41c2-9342-9dc6871c35dd','foo','user.attribute'),('a95fd805-8e80-4603-8285-32d4ed4244d6','true','access.token.claim'),('a95fd805-8e80-4603-8285-32d4ed4244d6','phone_number','claim.name'),('a95fd805-8e80-4603-8285-32d4ed4244d6','true','id.token.claim'),('a95fd805-8e80-4603-8285-32d4ed4244d6','true','introspection.token.claim'),('a95fd805-8e80-4603-8285-32d4ed4244d6','String','jsonType.label'),('a95fd805-8e80-4603-8285-32d4ed4244d6','phoneNumber','user.attribute'),('a95fd805-8e80-4603-8285-32d4ed4244d6','true','userinfo.token.claim'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','true','access.token.claim'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','false','aggregate.attrs'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','phoneNumber','claim.name'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','true','id.token.claim'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','true','introspection.token.claim'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','String','jsonType.label'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','false','lightweight.claim'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','false','multivalued'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','phoneNumber','user.attribute'),('ab99bdef-8a03-429e-b228-19eae30c9a3b','true','userinfo.token.claim'),('abeebcf6-7010-44a1-bfd5-98ad62f64f4f','true','access.token.claim'),('abeebcf6-7010-44a1-bfd5-98ad62f64f4f','nickname','claim.name'),('abeebcf6-7010-44a1-bfd5-98ad62f64f4f','true','id.token.claim'),('abeebcf6-7010-44a1-bfd5-98ad62f64f4f','true','introspection.token.claim'),('abeebcf6-7010-44a1-bfd5-98ad62f64f4f','String','jsonType.label'),('abeebcf6-7010-44a1-bfd5-98ad62f64f4f','nickname','user.attribute'),('abeebcf6-7010-44a1-bfd5-98ad62f64f4f','true','userinfo.token.claim'),('afc98f8f-bf80-4400-b63a-865f8920c67b','true','access.token.claim'),('afc98f8f-bf80-4400-b63a-865f8920c67b','website','claim.name'),('afc98f8f-bf80-4400-b63a-865f8920c67b','true','id.token.claim'),('afc98f8f-bf80-4400-b63a-865f8920c67b','true','introspection.token.claim'),('afc98f8f-bf80-4400-b63a-865f8920c67b','String','jsonType.label'),('afc98f8f-bf80-4400-b63a-865f8920c67b','website','user.attribute'),('afc98f8f-bf80-4400-b63a-865f8920c67b','true','userinfo.token.claim'),('b056c7c3-0492-4b90-8843-afbe37fde4f4','true','access.token.claim'),('b056c7c3-0492-4b90-8843-afbe37fde4f4','auth_time','claim.name'),('b056c7c3-0492-4b90-8843-afbe37fde4f4','true','id.token.claim'),('b056c7c3-0492-4b90-8843-afbe37fde4f4','true','introspection.token.claim'),('b056c7c3-0492-4b90-8843-afbe37fde4f4','long','jsonType.label'),('b056c7c3-0492-4b90-8843-afbe37fde4f4','AUTH_TIME','user.session.note'),('b513d173-09d2-4722-9fb1-8f335265ec25','true','access.token.claim'),('b513d173-09d2-4722-9fb1-8f335265ec25','locale','claim.name'),('b513d173-09d2-4722-9fb1-8f335265ec25','true','id.token.claim'),('b513d173-09d2-4722-9fb1-8f335265ec25','true','introspection.token.claim'),('b513d173-09d2-4722-9fb1-8f335265ec25','String','jsonType.label'),('b513d173-09d2-4722-9fb1-8f335265ec25','locale','user.attribute'),('b513d173-09d2-4722-9fb1-8f335265ec25','true','userinfo.token.claim'),('b9412f18-0692-4be4-bf8c-84c1285308bb','true','access.token.claim'),('b9412f18-0692-4be4-bf8c-84c1285308bb','updated_at','claim.name'),('b9412f18-0692-4be4-bf8c-84c1285308bb','true','id.token.claim'),('b9412f18-0692-4be4-bf8c-84c1285308bb','true','introspection.token.claim'),('b9412f18-0692-4be4-bf8c-84c1285308bb','long','jsonType.label'),('b9412f18-0692-4be4-bf8c-84c1285308bb','updatedAt','user.attribute'),('b9412f18-0692-4be4-bf8c-84c1285308bb','true','userinfo.token.claim'),('bd547a60-2388-49be-9dfb-f515da7413cb','true','access.token.claim'),('bd547a60-2388-49be-9dfb-f515da7413cb','false','aggregate.attrs'),('bd547a60-2388-49be-9dfb-f515da7413cb','gender','claim.name'),('bd547a60-2388-49be-9dfb-f515da7413cb','true','id.token.claim'),('bd547a60-2388-49be-9dfb-f515da7413cb','true','introspection.token.claim'),('bd547a60-2388-49be-9dfb-f515da7413cb','String','jsonType.label'),('bd547a60-2388-49be-9dfb-f515da7413cb','false','lightweight.claim'),('bd547a60-2388-49be-9dfb-f515da7413cb','false','multivalued'),('bd547a60-2388-49be-9dfb-f515da7413cb','gender','user.attribute'),('bd547a60-2388-49be-9dfb-f515da7413cb','true','userinfo.token.claim'),('c35e7dd1-7350-4721-b1db-93d3e870ac18','true','access.token.claim'),('c35e7dd1-7350-4721-b1db-93d3e870ac18','zoneinfo','claim.name'),('c35e7dd1-7350-4721-b1db-93d3e870ac18','true','id.token.claim'),('c35e7dd1-7350-4721-b1db-93d3e870ac18','true','introspection.token.claim'),('c35e7dd1-7350-4721-b1db-93d3e870ac18','String','jsonType.label'),('c35e7dd1-7350-4721-b1db-93d3e870ac18','zoneinfo','user.attribute'),('c35e7dd1-7350-4721-b1db-93d3e870ac18','true','userinfo.token.claim'),('c73c7369-514a-4b1c-86d2-919ca457c03e','true','access.token.claim'),('c73c7369-514a-4b1c-86d2-919ca457c03e','true','id.token.claim'),('c73c7369-514a-4b1c-86d2-919ca457c03e','true','introspection.token.claim'),('c924513c-17e7-4668-a31e-d28f3f9f217b','true','access.token.claim'),('c924513c-17e7-4668-a31e-d28f3f9f217b','country','claim.name'),('c924513c-17e7-4668-a31e-d28f3f9f217b','true','id.token.claim'),('c924513c-17e7-4668-a31e-d28f3f9f217b','true','introspection.token.claim'),('c924513c-17e7-4668-a31e-d28f3f9f217b','String','jsonType.label'),('c924513c-17e7-4668-a31e-d28f3f9f217b','false','lightweight.claim'),('c924513c-17e7-4668-a31e-d28f3f9f217b','country','user.attribute'),('c924513c-17e7-4668-a31e-d28f3f9f217b','true','userinfo.token.claim'),('ccd259ef-ffae-4c06-8bc6-24ca779bf56a','true','access.token.claim'),('ccd259ef-ffae-4c06-8bc6-24ca779bf56a','given_name','claim.name'),('ccd259ef-ffae-4c06-8bc6-24ca779bf56a','true','id.token.claim'),('ccd259ef-ffae-4c06-8bc6-24ca779bf56a','true','introspection.token.claim'),('ccd259ef-ffae-4c06-8bc6-24ca779bf56a','String','jsonType.label'),('ccd259ef-ffae-4c06-8bc6-24ca779bf56a','firstName','user.attribute'),('ccd259ef-ffae-4c06-8bc6-24ca779bf56a','true','userinfo.token.claim'),('cdc9038a-d348-490e-a1db-68e69941731d','true','access.token.claim'),('cdc9038a-d348-490e-a1db-68e69941731d','true','id.token.claim'),('cdc9038a-d348-490e-a1db-68e69941731d','true','introspection.token.claim'),('cdc9038a-d348-490e-a1db-68e69941731d','String','jsonType.label'),('cdc9038a-d348-490e-a1db-68e69941731d','false','lightweight.claim'),('cdc9038a-d348-490e-a1db-68e69941731d','postalCode','user.attribute'),('cdc9038a-d348-490e-a1db-68e69941731d','true','userinfo.token.claim'),('cf7c508c-2a1c-4ae6-b7d2-d2dee46cb952','true','access.token.claim'),('cf7c508c-2a1c-4ae6-b7d2-d2dee46cb952','true','introspection.token.claim'),('d051ad1e-35c6-4b1f-99f8-7596c104d5b1','true','access.token.claim'),('d051ad1e-35c6-4b1f-99f8-7596c104d5b1','middle_name','claim.name'),('d051ad1e-35c6-4b1f-99f8-7596c104d5b1','true','id.token.claim'),('d051ad1e-35c6-4b1f-99f8-7596c104d5b1','true','introspection.token.claim'),('d051ad1e-35c6-4b1f-99f8-7596c104d5b1','String','jsonType.label'),('d051ad1e-35c6-4b1f-99f8-7596c104d5b1','middleName','user.attribute'),('d051ad1e-35c6-4b1f-99f8-7596c104d5b1','true','userinfo.token.claim'),('d2b00fab-6fb6-43f1-a6b7-5211d82d8676','true','access.token.claim'),('d2b00fab-6fb6-43f1-a6b7-5211d82d8676','phone_number_verified','claim.name'),('d2b00fab-6fb6-43f1-a6b7-5211d82d8676','true','id.token.claim'),('d2b00fab-6fb6-43f1-a6b7-5211d82d8676','true','introspection.token.claim'),('d2b00fab-6fb6-43f1-a6b7-5211d82d8676','boolean','jsonType.label'),('d2b00fab-6fb6-43f1-a6b7-5211d82d8676','phoneNumberVerified','user.attribute'),('d2b00fab-6fb6-43f1-a6b7-5211d82d8676','true','userinfo.token.claim'),('d66f00f5-763d-49fc-a481-7cbfa3693c37','true','access.token.claim'),('d66f00f5-763d-49fc-a481-7cbfa3693c37','resource_access.${client_id}.roles','claim.name'),('d66f00f5-763d-49fc-a481-7cbfa3693c37','true','introspection.token.claim'),('d66f00f5-763d-49fc-a481-7cbfa3693c37','String','jsonType.label'),('d66f00f5-763d-49fc-a481-7cbfa3693c37','true','multivalued'),('d66f00f5-763d-49fc-a481-7cbfa3693c37','foo','user.attribute'),('d69ad0a9-b975-40b8-ad8f-5c0cad32ec4e','true','access.token.claim'),('d69ad0a9-b975-40b8-ad8f-5c0cad32ec4e','middle_name','claim.name'),('d69ad0a9-b975-40b8-ad8f-5c0cad32ec4e','true','id.token.claim'),('d69ad0a9-b975-40b8-ad8f-5c0cad32ec4e','true','introspection.token.claim'),('d69ad0a9-b975-40b8-ad8f-5c0cad32ec4e','String','jsonType.label'),('d69ad0a9-b975-40b8-ad8f-5c0cad32ec4e','middleName','user.attribute'),('d69ad0a9-b975-40b8-ad8f-5c0cad32ec4e','true','userinfo.token.claim'),('d6a5ac91-5aaf-466a-9930-7f76ad66658b','true','access.token.claim'),('d6a5ac91-5aaf-466a-9930-7f76ad66658b','birthdate','claim.name'),('d6a5ac91-5aaf-466a-9930-7f76ad66658b','true','id.token.claim'),('d6a5ac91-5aaf-466a-9930-7f76ad66658b','true','introspection.token.claim'),('d6a5ac91-5aaf-466a-9930-7f76ad66658b','String','jsonType.label'),('d6a5ac91-5aaf-466a-9930-7f76ad66658b','birthdate','user.attribute'),('d6a5ac91-5aaf-466a-9930-7f76ad66658b','true','userinfo.token.claim'),('d823944e-362b-4a3c-8b47-f5bc94fe4742','true','access.token.claim'),('d823944e-362b-4a3c-8b47-f5bc94fe4742','picture','claim.name'),('d823944e-362b-4a3c-8b47-f5bc94fe4742','true','id.token.claim'),('d823944e-362b-4a3c-8b47-f5bc94fe4742','true','introspection.token.claim'),('d823944e-362b-4a3c-8b47-f5bc94fe4742','String','jsonType.label'),('d823944e-362b-4a3c-8b47-f5bc94fe4742','picture','user.attribute'),('d823944e-362b-4a3c-8b47-f5bc94fe4742','true','userinfo.token.claim'),('dca01981-3f5d-4a16-929c-6414bc37a7b9','true','access.token.claim'),('dca01981-3f5d-4a16-929c-6414bc37a7b9','family_name','claim.name'),('dca01981-3f5d-4a16-929c-6414bc37a7b9','true','id.token.claim'),('dca01981-3f5d-4a16-929c-6414bc37a7b9','true','introspection.token.claim'),('dca01981-3f5d-4a16-929c-6414bc37a7b9','String','jsonType.label'),('dca01981-3f5d-4a16-929c-6414bc37a7b9','lastName','user.attribute'),('dca01981-3f5d-4a16-929c-6414bc37a7b9','true','userinfo.token.claim'),('dd5e9cd7-006c-4d46-b1d7-66141213fdef','true','access.token.claim'),('dd5e9cd7-006c-4d46-b1d7-66141213fdef','phone_number','claim.name'),('dd5e9cd7-006c-4d46-b1d7-66141213fdef','true','id.token.claim'),('dd5e9cd7-006c-4d46-b1d7-66141213fdef','true','introspection.token.claim'),('dd5e9cd7-006c-4d46-b1d7-66141213fdef','String','jsonType.label'),('dd5e9cd7-006c-4d46-b1d7-66141213fdef','phoneNumber','user.attribute'),('dd5e9cd7-006c-4d46-b1d7-66141213fdef','true','userinfo.token.claim'),('dfe28f18-eb70-4ced-b708-48f6325362f4','true','access.token.claim'),('dfe28f18-eb70-4ced-b708-48f6325362f4','true','introspection.token.claim'),('e111805a-623d-4699-af88-ea0db3b2a89b','true','access.token.claim'),('e111805a-623d-4699-af88-ea0db3b2a89b','birthdate','claim.name'),('e111805a-623d-4699-af88-ea0db3b2a89b','true','id.token.claim'),('e111805a-623d-4699-af88-ea0db3b2a89b','true','introspection.token.claim'),('e111805a-623d-4699-af88-ea0db3b2a89b','String','jsonType.label'),('e111805a-623d-4699-af88-ea0db3b2a89b','birthdate','user.attribute'),('e111805a-623d-4699-af88-ea0db3b2a89b','true','userinfo.token.claim'),('e3c44cd1-b231-4611-885e-7b6eb0182b84','true','access.token.claim'),('e3c44cd1-b231-4611-885e-7b6eb0182b84','email','claim.name'),('e3c44cd1-b231-4611-885e-7b6eb0182b84','true','id.token.claim'),('e3c44cd1-b231-4611-885e-7b6eb0182b84','true','introspection.token.claim'),('e3c44cd1-b231-4611-885e-7b6eb0182b84','String','jsonType.label'),('e3c44cd1-b231-4611-885e-7b6eb0182b84','email','user.attribute'),('e3c44cd1-b231-4611-885e-7b6eb0182b84','true','userinfo.token.claim'),('e5e82ee1-bffb-44d9-95b3-e4a4b3c74b48','true','access.token.claim'),('e5e82ee1-bffb-44d9-95b3-e4a4b3c74b48','true','id.token.claim'),('e5e82ee1-bffb-44d9-95b3-e4a4b3c74b48','true','introspection.token.claim'),('e5e82ee1-bffb-44d9-95b3-e4a4b3c74b48','true','userinfo.token.claim'),('e9bac6c5-94d3-432c-b8d7-d136473f7ae4','true','access.token.claim'),('e9bac6c5-94d3-432c-b8d7-d136473f7ae4','upn','claim.name'),('e9bac6c5-94d3-432c-b8d7-d136473f7ae4','true','id.token.claim'),('e9bac6c5-94d3-432c-b8d7-d136473f7ae4','true','introspection.token.claim'),('e9bac6c5-94d3-432c-b8d7-d136473f7ae4','String','jsonType.label'),('e9bac6c5-94d3-432c-b8d7-d136473f7ae4','username','user.attribute'),('e9bac6c5-94d3-432c-b8d7-d136473f7ae4','true','userinfo.token.claim'),('ebc8c0d9-448c-4d0e-9c87-7a245b51fa77','true','access.token.claim'),('ebc8c0d9-448c-4d0e-9c87-7a245b51fa77','updated_at','claim.name'),('ebc8c0d9-448c-4d0e-9c87-7a245b51fa77','true','id.token.claim'),('ebc8c0d9-448c-4d0e-9c87-7a245b51fa77','true','introspection.token.claim'),('ebc8c0d9-448c-4d0e-9c87-7a245b51fa77','long','jsonType.label'),('ebc8c0d9-448c-4d0e-9c87-7a245b51fa77','updatedAt','user.attribute'),('ebc8c0d9-448c-4d0e-9c87-7a245b51fa77','true','userinfo.token.claim'),('eda27655-fad2-4d6a-8102-9182d3ae8a61','true','access.token.claim'),('eda27655-fad2-4d6a-8102-9182d3ae8a61','realm_access.roles','claim.name'),('eda27655-fad2-4d6a-8102-9182d3ae8a61','true','introspection.token.claim'),('eda27655-fad2-4d6a-8102-9182d3ae8a61','String','jsonType.label'),('eda27655-fad2-4d6a-8102-9182d3ae8a61','true','multivalued'),('eda27655-fad2-4d6a-8102-9182d3ae8a61','foo','user.attribute'),('ee39c80c-4d4b-4e40-9263-a5e360589adf','true','access.token.claim'),('ee39c80c-4d4b-4e40-9263-a5e360589adf','groups','claim.name'),('ee39c80c-4d4b-4e40-9263-a5e360589adf','true','id.token.claim'),('ee39c80c-4d4b-4e40-9263-a5e360589adf','true','introspection.token.claim'),('ee39c80c-4d4b-4e40-9263-a5e360589adf','String','jsonType.label'),('ee39c80c-4d4b-4e40-9263-a5e360589adf','true','multivalued'),('ee39c80c-4d4b-4e40-9263-a5e360589adf','foo','user.attribute'),('ee972c58-9040-44e7-a8ab-53ce904f9058','true','access.token.claim'),('ee972c58-9040-44e7-a8ab-53ce904f9058','postalCode','claim.name'),('ee972c58-9040-44e7-a8ab-53ce904f9058','true','id.token.claim'),('ee972c58-9040-44e7-a8ab-53ce904f9058','true','introspection.token.claim'),('ee972c58-9040-44e7-a8ab-53ce904f9058','String','jsonType.label'),('ee972c58-9040-44e7-a8ab-53ce904f9058','false','lightweight.claim'),('ee972c58-9040-44e7-a8ab-53ce904f9058','postalCode','user.attribute'),('ee972c58-9040-44e7-a8ab-53ce904f9058','true','userinfo.token.claim'),('ef23b018-d4cf-49ba-b99a-b58a86c7b8fe','Role','attribute.name'),('ef23b018-d4cf-49ba-b99a-b58a86c7b8fe','Basic','attribute.nameformat'),('ef23b018-d4cf-49ba-b99a-b58a86c7b8fe','false','single'),('f440fe9b-cde3-4cac-99f7-ac57f981e19f','true','access.token.claim'),('f440fe9b-cde3-4cac-99f7-ac57f981e19f','preferred_username','claim.name'),('f440fe9b-cde3-4cac-99f7-ac57f981e19f','true','id.token.claim'),('f440fe9b-cde3-4cac-99f7-ac57f981e19f','true','introspection.token.claim'),('f440fe9b-cde3-4cac-99f7-ac57f981e19f','String','jsonType.label'),('f440fe9b-cde3-4cac-99f7-ac57f981e19f','username','user.attribute'),('f440fe9b-cde3-4cac-99f7-ac57f981e19f','true','userinfo.token.claim'),('f4676828-d750-4341-9d0b-f63b9bd7aaf9','true','access.token.claim'),('f4676828-d750-4341-9d0b-f63b9bd7aaf9','email_verified','claim.name'),('f4676828-d750-4341-9d0b-f63b9bd7aaf9','true','id.token.claim'),('f4676828-d750-4341-9d0b-f63b9bd7aaf9','true','introspection.token.claim'),('f4676828-d750-4341-9d0b-f63b9bd7aaf9','boolean','jsonType.label'),('f4676828-d750-4341-9d0b-f63b9bd7aaf9','emailVerified','user.attribute'),('f4676828-d750-4341-9d0b-f63b9bd7aaf9','true','userinfo.token.claim'),('f50da57c-f998-4267-b8a8-417c4e6acf4f','true','access.token.claim'),('f50da57c-f998-4267-b8a8-417c4e6acf4f','gender','claim.name'),('f50da57c-f998-4267-b8a8-417c4e6acf4f','true','id.token.claim'),('f50da57c-f998-4267-b8a8-417c4e6acf4f','true','introspection.token.claim'),('f50da57c-f998-4267-b8a8-417c4e6acf4f','String','jsonType.label'),('f50da57c-f998-4267-b8a8-417c4e6acf4f','gender','user.attribute'),('f50da57c-f998-4267-b8a8-417c4e6acf4f','true','userinfo.token.claim'),('f749a70c-38e8-4830-922f-05e40c19eeaf','true','access.token.claim'),('f749a70c-38e8-4830-922f-05e40c19eeaf','upn','claim.name'),('f749a70c-38e8-4830-922f-05e40c19eeaf','true','id.token.claim'),('f749a70c-38e8-4830-922f-05e40c19eeaf','true','introspection.token.claim'),('f749a70c-38e8-4830-922f-05e40c19eeaf','String','jsonType.label'),('f749a70c-38e8-4830-922f-05e40c19eeaf','username','user.attribute'),('f749a70c-38e8-4830-922f-05e40c19eeaf','true','userinfo.token.claim'),('fb6d94ba-2809-4f63-a95c-d84b3565df79','true','access.token.claim'),('fb6d94ba-2809-4f63-a95c-d84b3565df79','updated_at','claim.name'),('fb6d94ba-2809-4f63-a95c-d84b3565df79','true','id.token.claim'),('fb6d94ba-2809-4f63-a95c-d84b3565df79','true','introspection.token.claim'),('fb6d94ba-2809-4f63-a95c-d84b3565df79','long','jsonType.label'),('fb6d94ba-2809-4f63-a95c-d84b3565df79','updatedAt','user.attribute'),('fb6d94ba-2809-4f63-a95c-d84b3565df79','true','userinfo.token.claim');
/*!40000 ALTER TABLE `PROTOCOL_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM`
--

DROP TABLE IF EXISTS `REALM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM` (
  `ID` varchar(36) NOT NULL,
  `ACCESS_CODE_LIFESPAN` int DEFAULT NULL,
  `USER_ACTION_LIFESPAN` int DEFAULT NULL,
  `ACCESS_TOKEN_LIFESPAN` int DEFAULT NULL,
  `ACCOUNT_THEME` varchar(255) DEFAULT NULL,
  `ADMIN_THEME` varchar(255) DEFAULT NULL,
  `EMAIL_THEME` varchar(255) DEFAULT NULL,
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `EVENTS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `EVENTS_EXPIRATION` bigint DEFAULT NULL,
  `LOGIN_THEME` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int DEFAULT NULL,
  `PASSWORD_POLICY` text,
  `REGISTRATION_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `REMEMBER_ME` tinyint NOT NULL DEFAULT '0',
  `RESET_PASSWORD_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `SOCIAL` tinyint NOT NULL DEFAULT '0',
  `SSL_REQUIRED` varchar(255) DEFAULT NULL,
  `SSO_IDLE_TIMEOUT` int DEFAULT NULL,
  `SSO_MAX_LIFESPAN` int DEFAULT NULL,
  `UPDATE_PROFILE_ON_SOC_LOGIN` tinyint NOT NULL DEFAULT '0',
  `VERIFY_EMAIL` tinyint NOT NULL DEFAULT '0',
  `MASTER_ADMIN_CLIENT` varchar(36) DEFAULT NULL,
  `LOGIN_LIFESPAN` int DEFAULT NULL,
  `INTERNATIONALIZATION_ENABLED` tinyint NOT NULL DEFAULT '0',
  `DEFAULT_LOCALE` varchar(255) DEFAULT NULL,
  `REG_EMAIL_AS_USERNAME` tinyint NOT NULL DEFAULT '0',
  `ADMIN_EVENTS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `ADMIN_EVENTS_DETAILS_ENABLED` tinyint NOT NULL DEFAULT '0',
  `EDIT_USERNAME_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `OTP_POLICY_COUNTER` int DEFAULT '0',
  `OTP_POLICY_WINDOW` int DEFAULT '1',
  `OTP_POLICY_PERIOD` int DEFAULT '30',
  `OTP_POLICY_DIGITS` int DEFAULT '6',
  `OTP_POLICY_ALG` varchar(36) DEFAULT 'HmacSHA1',
  `OTP_POLICY_TYPE` varchar(36) DEFAULT 'totp',
  `BROWSER_FLOW` varchar(36) DEFAULT NULL,
  `REGISTRATION_FLOW` varchar(36) DEFAULT NULL,
  `DIRECT_GRANT_FLOW` varchar(36) DEFAULT NULL,
  `RESET_CREDENTIALS_FLOW` varchar(36) DEFAULT NULL,
  `CLIENT_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `OFFLINE_SESSION_IDLE_TIMEOUT` int DEFAULT '0',
  `REVOKE_REFRESH_TOKEN` tinyint NOT NULL DEFAULT '0',
  `ACCESS_TOKEN_LIFE_IMPLICIT` int DEFAULT '0',
  `LOGIN_WITH_EMAIL_ALLOWED` tinyint NOT NULL DEFAULT '1',
  `DUPLICATE_EMAILS_ALLOWED` tinyint NOT NULL DEFAULT '0',
  `DOCKER_AUTH_FLOW` varchar(36) DEFAULT NULL,
  `REFRESH_TOKEN_MAX_REUSE` int DEFAULT '0',
  `ALLOW_USER_MANAGED_ACCESS` tinyint NOT NULL DEFAULT '0',
  `SSO_MAX_LIFESPAN_REMEMBER_ME` int NOT NULL,
  `SSO_IDLE_TIMEOUT_REMEMBER_ME` int NOT NULL,
  `DEFAULT_ROLE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_ORVSDMLA56612EAEFIQ6WL5OI` (`NAME`),
  KEY `IDX_REALM_MASTER_ADM_CLI` (`MASTER_ADMIN_CLIENT`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM`
--

LOCK TABLES `REALM` WRITE;
/*!40000 ALTER TABLE `REALM` DISABLE KEYS */;
INSERT INTO `REALM` VALUES ('15e56e88-e77b-45e1-afa4-0d9a64309354',60,300,300,NULL,NULL,NULL,1,0,0,NULL,'nextjs',0,NULL,1,1,1,0,'EXTERNAL',1800,36000,0,0,'899df6e9-d50a-4662-813c-fc672edcdbdf',1800,0,NULL,0,0,0,0,0,1,30,6,'HmacSHA1','totp','04a2e250-5e3f-4eb8-8ad1-0149b53e38e0','845a07b8-ea1c-49d1-b83d-29fd2b16a5a4','2c1b348d-12ca-4d9f-af35-f127cb7a7929','a249d63e-f82a-4ff7-a4ae-132f2a6f9232','2167cc44-efb2-4167-ae7a-d5c91fe6e546',2592000,0,900,1,0,'13807a8e-4855-440e-ab00-4099e76f425f',0,0,0,0,'9a460e54-da96-4919-b647-d0d3397205f3'),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',60,300,300,NULL,NULL,NULL,1,0,0,NULL,'forum',0,NULL,1,1,1,0,'EXTERNAL',1800,36000,0,0,'8f68b73b-954d-4245-9882-551d3823aa52',1800,0,NULL,0,0,0,0,0,1,30,6,'HmacSHA1','totp','1a13a6ba-a1f7-47c3-b148-6189e265f6da','9ab7f66f-07f5-4353-a501-5c5fb4f496e7','ce49cba2-a7df-4994-99c4-5309c1f3fae3','fc2d16aa-f436-4b9b-9af7-08826e2b35c6','ed269c54-83da-4673-941f-423fdcdecf89',2592000,1,900,1,0,'360e6019-57a9-45f4-be34-89bdba03631b',1,0,0,0,'f1280c1e-2251-4910-ae43-eadba9f9f379'),('f65da957-0a1a-47d4-9781-0118b7c15e3d',60,300,60,NULL,NULL,NULL,1,0,0,NULL,'master',0,NULL,0,0,0,0,'EXTERNAL',1800,36000,0,0,'1fc8e766-9ec9-49e7-ad45-f76655d6508c',1800,0,NULL,0,0,0,0,0,1,30,6,'HmacSHA1','totp','9403ca4f-e9d7-436a-b01a-1d19bcd4ba13','d19c076d-9f45-403e-b274-a1e5965ffabf','e9fa2f24-b105-4430-8f57-fbd639b3e1c4','b38342c1-0f66-4753-8022-1d8cc2a126ac','0bc778f0-74bd-4d03-9855-912221d0e720',2592000,0,900,1,0,'2e9db36b-062b-4ac0-9022-d245cb9d457d',0,0,0,0,'a2f57d4a-97ca-4fe5-813a-36e942bbd785');
/*!40000 ALTER TABLE `REALM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ATTRIBUTE`
--

DROP TABLE IF EXISTS `REALM_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`NAME`,`REALM_ID`),
  KEY `IDX_REALM_ATTR_REALM` (`REALM_ID`),
  CONSTRAINT `FK_8SHXD6L3E9ATQUKACXGPFFPTW` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ATTRIBUTE`
--

LOCK TABLES `REALM_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` DISABLE KEYS */;
INSERT INTO `REALM_ATTRIBUTE` VALUES ('_browser_header.contentSecurityPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),('_browser_header.contentSecurityPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),('_browser_header.contentSecurityPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','frame-src \'self\'; frame-ancestors \'self\'; object-src \'none\';'),('_browser_header.contentSecurityPolicyReportOnly','15e56e88-e77b-45e1-afa4-0d9a64309354',''),('_browser_header.contentSecurityPolicyReportOnly','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('_browser_header.contentSecurityPolicyReportOnly','f65da957-0a1a-47d4-9781-0118b7c15e3d',''),('_browser_header.referrerPolicy','15e56e88-e77b-45e1-afa4-0d9a64309354','no-referrer'),('_browser_header.referrerPolicy','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','no-referrer'),('_browser_header.referrerPolicy','f65da957-0a1a-47d4-9781-0118b7c15e3d','no-referrer'),('_browser_header.strictTransportSecurity','15e56e88-e77b-45e1-afa4-0d9a64309354','max-age=31536000; includeSubDomains'),('_browser_header.strictTransportSecurity','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','max-age=31536000; includeSubDomains'),('_browser_header.strictTransportSecurity','f65da957-0a1a-47d4-9781-0118b7c15e3d','max-age=31536000; includeSubDomains'),('_browser_header.xContentTypeOptions','15e56e88-e77b-45e1-afa4-0d9a64309354','nosniff'),('_browser_header.xContentTypeOptions','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','nosniff'),('_browser_header.xContentTypeOptions','f65da957-0a1a-47d4-9781-0118b7c15e3d','nosniff'),('_browser_header.xFrameOptions','15e56e88-e77b-45e1-afa4-0d9a64309354','SAMEORIGIN'),('_browser_header.xFrameOptions','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','SAMEORIGIN'),('_browser_header.xFrameOptions','f65da957-0a1a-47d4-9781-0118b7c15e3d','SAMEORIGIN'),('_browser_header.xRobotsTag','15e56e88-e77b-45e1-afa4-0d9a64309354','none'),('_browser_header.xRobotsTag','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','none'),('_browser_header.xRobotsTag','f65da957-0a1a-47d4-9781-0118b7c15e3d','none'),('_browser_header.xXSSProtection','15e56e88-e77b-45e1-afa4-0d9a64309354','1; mode=block'),('_browser_header.xXSSProtection','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','1; mode=block'),('_browser_header.xXSSProtection','f65da957-0a1a-47d4-9781-0118b7c15e3d','1; mode=block'),('acr.loa.map','15e56e88-e77b-45e1-afa4-0d9a64309354','{}'),('acr.loa.map','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','{}'),('actionTokenGeneratedByAdminLifespan','15e56e88-e77b-45e1-afa4-0d9a64309354','43200'),('actionTokenGeneratedByAdminLifespan','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','43200'),('actionTokenGeneratedByUserLifespan','15e56e88-e77b-45e1-afa4-0d9a64309354','300'),('actionTokenGeneratedByUserLifespan','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','300'),('actionTokenGeneratedByUserLifespan.execute-actions','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('actionTokenGeneratedByUserLifespan.idp-verify-account-via-email','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('actionTokenGeneratedByUserLifespan.reset-credentials','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('actionTokenGeneratedByUserLifespan.verify-email','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('bruteForceProtected','15e56e88-e77b-45e1-afa4-0d9a64309354','false'),('bruteForceProtected','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','false'),('bruteForceProtected','f65da957-0a1a-47d4-9781-0118b7c15e3d','false'),('cibaAuthRequestedUserHint','15e56e88-e77b-45e1-afa4-0d9a64309354','login_hint'),('cibaAuthRequestedUserHint','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','login_hint'),('cibaBackchannelTokenDeliveryMode','15e56e88-e77b-45e1-afa4-0d9a64309354','poll'),('cibaBackchannelTokenDeliveryMode','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','poll'),('cibaExpiresIn','15e56e88-e77b-45e1-afa4-0d9a64309354','120'),('cibaExpiresIn','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','120'),('cibaInterval','15e56e88-e77b-45e1-afa4-0d9a64309354','5'),('cibaInterval','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','5'),('client-policies.policies','15e56e88-e77b-45e1-afa4-0d9a64309354','{\"policies\":[]}'),('client-policies.policies','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','{\"policies\":[]}'),('client-policies.profiles','15e56e88-e77b-45e1-afa4-0d9a64309354','{\"profiles\":[]}'),('client-policies.profiles','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','{\"profiles\":[]}'),('clientOfflineSessionIdleTimeout','15e56e88-e77b-45e1-afa4-0d9a64309354','0'),('clientOfflineSessionIdleTimeout','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0'),('clientOfflineSessionMaxLifespan','15e56e88-e77b-45e1-afa4-0d9a64309354','0'),('clientOfflineSessionMaxLifespan','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0'),('clientSessionIdleTimeout','15e56e88-e77b-45e1-afa4-0d9a64309354','0'),('clientSessionIdleTimeout','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0'),('clientSessionMaxLifespan','15e56e88-e77b-45e1-afa4-0d9a64309354','0'),('clientSessionMaxLifespan','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0'),('defaultSignatureAlgorithm','15e56e88-e77b-45e1-afa4-0d9a64309354','RS256'),('defaultSignatureAlgorithm','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','RS256'),('defaultSignatureAlgorithm','f65da957-0a1a-47d4-9781-0118b7c15e3d','RS256'),('displayName','15e56e88-e77b-45e1-afa4-0d9a64309354',''),('displayName','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','Forum SSO'),('displayName','f65da957-0a1a-47d4-9781-0118b7c15e3d','Keycloak'),('displayNameHtml','15e56e88-e77b-45e1-afa4-0d9a64309354',''),('displayNameHtml','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('displayNameHtml','f65da957-0a1a-47d4-9781-0118b7c15e3d','<div class=\"kc-logo-text\"><span>Keycloak</span></div>'),('failureFactor','15e56e88-e77b-45e1-afa4-0d9a64309354','30'),('failureFactor','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','30'),('failureFactor','f65da957-0a1a-47d4-9781-0118b7c15e3d','30'),('firstBrokerLoginFlowId','15e56e88-e77b-45e1-afa4-0d9a64309354','b126c8f3-7f16-40b6-be8c-9722c4d31916'),('firstBrokerLoginFlowId','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ac578b97-839e-4d63-a7a1-2ca31920c6f1'),('firstBrokerLoginFlowId','f65da957-0a1a-47d4-9781-0118b7c15e3d','2a2bbd2e-7755-4fa3-91e8-b634d1923b77'),('frontendUrl','15e56e88-e77b-45e1-afa4-0d9a64309354',''),('frontendUrl','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('maxDeltaTimeSeconds','15e56e88-e77b-45e1-afa4-0d9a64309354','43200'),('maxDeltaTimeSeconds','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','43200'),('maxDeltaTimeSeconds','f65da957-0a1a-47d4-9781-0118b7c15e3d','43200'),('maxFailureWaitSeconds','15e56e88-e77b-45e1-afa4-0d9a64309354','900'),('maxFailureWaitSeconds','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','900'),('maxFailureWaitSeconds','f65da957-0a1a-47d4-9781-0118b7c15e3d','900'),('maxTemporaryLockouts','15e56e88-e77b-45e1-afa4-0d9a64309354','0'),('maxTemporaryLockouts','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0'),('maxTemporaryLockouts','f65da957-0a1a-47d4-9781-0118b7c15e3d','0'),('minimumQuickLoginWaitSeconds','15e56e88-e77b-45e1-afa4-0d9a64309354','60'),('minimumQuickLoginWaitSeconds','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','60'),('minimumQuickLoginWaitSeconds','f65da957-0a1a-47d4-9781-0118b7c15e3d','60'),('oauth2DeviceCodeLifespan','15e56e88-e77b-45e1-afa4-0d9a64309354','600'),('oauth2DeviceCodeLifespan','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','600'),('oauth2DevicePollingInterval','15e56e88-e77b-45e1-afa4-0d9a64309354','5'),('oauth2DevicePollingInterval','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','5'),('offlineSessionMaxLifespan','15e56e88-e77b-45e1-afa4-0d9a64309354','5184000'),('offlineSessionMaxLifespan','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','5184000'),('offlineSessionMaxLifespan','f65da957-0a1a-47d4-9781-0118b7c15e3d','5184000'),('offlineSessionMaxLifespanEnabled','15e56e88-e77b-45e1-afa4-0d9a64309354','false'),('offlineSessionMaxLifespanEnabled','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','false'),('offlineSessionMaxLifespanEnabled','f65da957-0a1a-47d4-9781-0118b7c15e3d','false'),('organizationsEnabled','15e56e88-e77b-45e1-afa4-0d9a64309354','false'),('organizationsEnabled','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','false'),('parRequestUriLifespan','15e56e88-e77b-45e1-afa4-0d9a64309354','60'),('parRequestUriLifespan','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','60'),('permanentLockout','15e56e88-e77b-45e1-afa4-0d9a64309354','false'),('permanentLockout','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','false'),('permanentLockout','f65da957-0a1a-47d4-9781-0118b7c15e3d','false'),('quickLoginCheckMilliSeconds','15e56e88-e77b-45e1-afa4-0d9a64309354','1000'),('quickLoginCheckMilliSeconds','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','1000'),('quickLoginCheckMilliSeconds','f65da957-0a1a-47d4-9781-0118b7c15e3d','1000'),('realmReusableOtpCode','15e56e88-e77b-45e1-afa4-0d9a64309354','false'),('realmReusableOtpCode','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','false'),('realmReusableOtpCode','f65da957-0a1a-47d4-9781-0118b7c15e3d','false'),('shortVerificationUri','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('waitIncrementSeconds','15e56e88-e77b-45e1-afa4-0d9a64309354','60'),('waitIncrementSeconds','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','60'),('waitIncrementSeconds','f65da957-0a1a-47d4-9781-0118b7c15e3d','60'),('webAuthnPolicyAttestationConveyancePreference','15e56e88-e77b-45e1-afa4-0d9a64309354','not specified'),('webAuthnPolicyAttestationConveyancePreference','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','not specified'),('webAuthnPolicyAttestationConveyancePreferencePasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354','not specified'),('webAuthnPolicyAttestationConveyancePreferencePasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','not specified'),('webAuthnPolicyAuthenticatorAttachment','15e56e88-e77b-45e1-afa4-0d9a64309354','not specified'),('webAuthnPolicyAuthenticatorAttachment','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','not specified'),('webAuthnPolicyAuthenticatorAttachmentPasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354','not specified'),('webAuthnPolicyAuthenticatorAttachmentPasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','not specified'),('webAuthnPolicyAvoidSameAuthenticatorRegister','15e56e88-e77b-45e1-afa4-0d9a64309354','false'),('webAuthnPolicyAvoidSameAuthenticatorRegister','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','false'),('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354','false'),('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','false'),('webAuthnPolicyCreateTimeout','15e56e88-e77b-45e1-afa4-0d9a64309354','0'),('webAuthnPolicyCreateTimeout','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0'),('webAuthnPolicyCreateTimeoutPasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354','0'),('webAuthnPolicyCreateTimeoutPasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','0'),('webAuthnPolicyRequireResidentKey','15e56e88-e77b-45e1-afa4-0d9a64309354','not specified'),('webAuthnPolicyRequireResidentKey','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','not specified'),('webAuthnPolicyRequireResidentKeyPasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354','not specified'),('webAuthnPolicyRequireResidentKeyPasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','not specified'),('webAuthnPolicyRpEntityName','15e56e88-e77b-45e1-afa4-0d9a64309354','keycloak'),('webAuthnPolicyRpEntityName','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','keycloak'),('webAuthnPolicyRpEntityNamePasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354','keycloak'),('webAuthnPolicyRpEntityNamePasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','keycloak'),('webAuthnPolicyRpId','15e56e88-e77b-45e1-afa4-0d9a64309354',''),('webAuthnPolicyRpId','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('webAuthnPolicyRpIdPasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354',''),('webAuthnPolicyRpIdPasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',''),('webAuthnPolicySignatureAlgorithms','15e56e88-e77b-45e1-afa4-0d9a64309354','ES256'),('webAuthnPolicySignatureAlgorithms','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ES256'),('webAuthnPolicySignatureAlgorithmsPasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354','ES256'),('webAuthnPolicySignatureAlgorithmsPasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','ES256'),('webAuthnPolicyUserVerificationRequirement','15e56e88-e77b-45e1-afa4-0d9a64309354','not specified'),('webAuthnPolicyUserVerificationRequirement','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','not specified'),('webAuthnPolicyUserVerificationRequirementPasswordless','15e56e88-e77b-45e1-afa4-0d9a64309354','not specified'),('webAuthnPolicyUserVerificationRequirementPasswordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','not specified');
/*!40000 ALTER TABLE `REALM_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_DEFAULT_GROUPS`
--

DROP TABLE IF EXISTS `REALM_DEFAULT_GROUPS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_DEFAULT_GROUPS` (
  `REALM_ID` varchar(36) NOT NULL,
  `GROUP_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`GROUP_ID`),
  UNIQUE KEY `CON_GROUP_ID_DEF_GROUPS` (`GROUP_ID`),
  KEY `IDX_REALM_DEF_GRP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_DEF_GROUPS_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_DEFAULT_GROUPS`
--

LOCK TABLES `REALM_DEFAULT_GROUPS` WRITE;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_DEFAULT_GROUPS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_ENABLED_EVENT_TYPES`
--

DROP TABLE IF EXISTS `REALM_ENABLED_EVENT_TYPES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_ENABLED_EVENT_TYPES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_TYPES_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NWEDRF5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_ENABLED_EVENT_TYPES`
--

LOCK TABLES `REALM_ENABLED_EVENT_TYPES` WRITE;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_ENABLED_EVENT_TYPES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_EVENTS_LISTENERS`
--

DROP TABLE IF EXISTS `REALM_EVENTS_LISTENERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_EVENTS_LISTENERS` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_EVT_LIST_REALM` (`REALM_ID`),
  CONSTRAINT `FK_H846O4H0W8EPX5NXEV9F5Y69J` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_EVENTS_LISTENERS`
--

LOCK TABLES `REALM_EVENTS_LISTENERS` WRITE;
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` DISABLE KEYS */;
INSERT INTO `REALM_EVENTS_LISTENERS` VALUES ('15e56e88-e77b-45e1-afa4-0d9a64309354','jboss-logging'),('7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','jboss-logging'),('f65da957-0a1a-47d4-9781-0118b7c15e3d','jboss-logging');
/*!40000 ALTER TABLE `REALM_EVENTS_LISTENERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_LOCALIZATIONS`
--

DROP TABLE IF EXISTS `REALM_LOCALIZATIONS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_LOCALIZATIONS` (
  `REALM_ID` varchar(255) NOT NULL,
  `LOCALE` varchar(255) NOT NULL,
  `TEXTS` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`REALM_ID`,`LOCALE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_LOCALIZATIONS`
--

LOCK TABLES `REALM_LOCALIZATIONS` WRITE;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_LOCALIZATIONS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_REQUIRED_CREDENTIAL`
--

DROP TABLE IF EXISTS `REALM_REQUIRED_CREDENTIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_REQUIRED_CREDENTIAL` (
  `TYPE` varchar(255) NOT NULL,
  `FORM_LABEL` varchar(255) DEFAULT NULL,
  `INPUT` tinyint NOT NULL DEFAULT '0',
  `SECRET` tinyint NOT NULL DEFAULT '0',
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`TYPE`),
  CONSTRAINT `FK_5HG65LYBEVAVKQFKI3KPONH9V` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_REQUIRED_CREDENTIAL`
--

LOCK TABLES `REALM_REQUIRED_CREDENTIAL` WRITE;
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` DISABLE KEYS */;
INSERT INTO `REALM_REQUIRED_CREDENTIAL` VALUES ('password','password',1,1,'15e56e88-e77b-45e1-afa4-0d9a64309354'),('password','password',1,1,'7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf'),('password','password',1,1,'f65da957-0a1a-47d4-9781-0118b7c15e3d');
/*!40000 ALTER TABLE `REALM_REQUIRED_CREDENTIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SMTP_CONFIG`
--

DROP TABLE IF EXISTS `REALM_SMTP_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_SMTP_CONFIG` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`NAME`),
  CONSTRAINT `FK_70EJ8XDXGXD0B9HH6180IRR0O` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SMTP_CONFIG`
--

LOCK TABLES `REALM_SMTP_CONFIG` WRITE;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_SMTP_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REALM_SUPPORTED_LOCALES`
--

DROP TABLE IF EXISTS `REALM_SUPPORTED_LOCALES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REALM_SUPPORTED_LOCALES` (
  `REALM_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`REALM_ID`,`VALUE`),
  KEY `IDX_REALM_SUPP_LOCAL_REALM` (`REALM_ID`),
  CONSTRAINT `FK_SUPPORTED_LOCALES_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REALM_SUPPORTED_LOCALES`
--

LOCK TABLES `REALM_SUPPORTED_LOCALES` WRITE;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` DISABLE KEYS */;
/*!40000 ALTER TABLE `REALM_SUPPORTED_LOCALES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REDIRECT_URIS`
--

DROP TABLE IF EXISTS `REDIRECT_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REDIRECT_URIS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_REDIR_URI_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_1BURS8PB4OUJ97H5WUPPAHV9F` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REDIRECT_URIS`
--

LOCK TABLES `REDIRECT_URIS` WRITE;
/*!40000 ALTER TABLE `REDIRECT_URIS` DISABLE KEYS */;
INSERT INTO `REDIRECT_URIS` VALUES ('0b0e3252-ffc4-4ae0-afc5-e7f1dde3dbae','/realms/master/account/*'),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','/realms/nextjs/account/*'),('45eab072-6c16-4ce9-895e-b8b1567fbb1c','/admin/nextjs/console/*'),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','/admin/forum/console/*'),('56e41688-ad77-45be-9ea5-5feeebdd496e','/admin/master/console/*'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','http://localhost:3000/api/auth/callback/keycloak'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','http://localhost:8072/*'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','http://gatewayserver:8072/*'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','http://localhost:3000/api/auth/callback/keycloak'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','http://localhost:8072/*'),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','/realms/forum/account/*'),('c50f75ca-b516-4ca8-ae8a-220102762e0b','/realms/forum/account/*'),('d994103a-c761-49e1-83cd-8dd421412620','/realms/master/account/*'),('df6ec42c-bf1a-4469-8a5f-fc30b17802bb','/realms/nextjs/account/*');
/*!40000 ALTER TABLE `REDIRECT_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_CONFIG`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REQUIRED_ACTION_CONFIG` (
  `REQUIRED_ACTION_ID` varchar(36) NOT NULL,
  `VALUE` longtext,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`REQUIRED_ACTION_ID`,`NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_CONFIG`
--

LOCK TABLES `REQUIRED_ACTION_CONFIG` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `REQUIRED_ACTION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REQUIRED_ACTION_PROVIDER`
--

DROP TABLE IF EXISTS `REQUIRED_ACTION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `REQUIRED_ACTION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `ALIAS` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `DEFAULT_ACTION` tinyint NOT NULL DEFAULT '0',
  `PROVIDER_ID` varchar(255) DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_REQ_ACT_PROV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_REQ_ACT_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REQUIRED_ACTION_PROVIDER`
--

LOCK TABLES `REQUIRED_ACTION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` DISABLE KEYS */;
INSERT INTO `REQUIRED_ACTION_PROVIDER` VALUES ('00d89784-fe98-4770-a90e-74e3015e4599','delete_account','Delete Account','f65da957-0a1a-47d4-9781-0118b7c15e3d',0,0,'delete_account',60),('0c17af98-ae09-4f45-a1d0-dcc0f2da1235','UPDATE_PROFILE','Update Profile','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'UPDATE_PROFILE',40),('0f19de5f-61bd-4b3b-abdc-a6d2a86e49b8','CONFIGURE_TOTP','Configure OTP','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'CONFIGURE_TOTP',10),('0f64952c-0515-4d30-80f3-cbd5c217e6fb','webauthn-register','Webauthn Register','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'webauthn-register',70),('17f61765-e9ea-4955-89ea-7ca4521ff5e1','VERIFY_PROFILE','Verify Profile','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'VERIFY_PROFILE',90),('1a79a829-9656-41b9-83e2-3f584e658076','delete_credential','Delete Credential','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'delete_credential',100),('1c0b54a9-3c69-4134-88dd-bb1593a1e28b','VERIFY_EMAIL','Verify Email','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'VERIFY_EMAIL',50),('2b9edc24-33b5-4058-946b-ffe3aeb251a5','delete_credential','Delete Credential','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'delete_credential',100),('41946906-ddec-4b58-82ac-12a6f1aa44ad','delete_account','Delete Account','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',0,0,'delete_account',60),('4a5dbfc4-d360-4bba-93ee-8ee62c8a786c','UPDATE_PASSWORD','Update Password','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'UPDATE_PASSWORD',30),('4bb439cf-690b-462b-a59f-d2ca1ed6f7ef','update_user_locale','Update User Locale','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'update_user_locale',1000),('4f48cd9e-afaa-470c-a1ea-0a312ec3c1fe','TERMS_AND_CONDITIONS','Terms and Conditions','f65da957-0a1a-47d4-9781-0118b7c15e3d',0,0,'TERMS_AND_CONDITIONS',20),('4fed9837-2933-427f-8d2e-01449d0e0de0','VERIFY_PROFILE','Verify Profile','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'VERIFY_PROFILE',90),('6a5e20ea-aee3-49df-8bc6-95c9bb2d0428','webauthn-register-passwordless','Webauthn Register Passwordless','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'webauthn-register-passwordless',80),('74d35f8e-43d4-47b7-b7f2-2d0987c01957','update_user_locale','Update User Locale','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'update_user_locale',1000),('8ff42522-9f36-47ac-b2d2-2b665fc82ac1','UPDATE_PROFILE','Update Profile','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'UPDATE_PROFILE',40),('916beb68-38a6-4ace-9f6e-5c6dd7c024a3','webauthn-register','Webauthn Register','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'webauthn-register',70),('96ee9434-cd44-4731-bc80-db7ddcc0d37d','UPDATE_PASSWORD','Update Password','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'UPDATE_PASSWORD',30),('9d168823-d0fc-41ae-8b4c-fae0b6dd1429','CONFIGURE_TOTP','Configure OTP','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'CONFIGURE_TOTP',10),('9d3ee0db-8e73-4a4b-97ed-0cb6bfdffc67','webauthn-register-passwordless','Webauthn Register Passwordless','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'webauthn-register-passwordless',80),('aae3fd24-4de1-49ef-9037-f68b57122ca0','delete_credential','Delete Credential','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'delete_credential',100),('ab73f508-c111-472b-b49f-45e4eb7c38b3','TERMS_AND_CONDITIONS','Terms and Conditions','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',0,0,'TERMS_AND_CONDITIONS',20),('ae83f855-225d-4e44-aa8e-ebbdc987a99b','TERMS_AND_CONDITIONS','Terms and Conditions','15e56e88-e77b-45e1-afa4-0d9a64309354',0,0,'TERMS_AND_CONDITIONS',20),('b7536452-e29e-4eda-a11e-400d0732347d','UPDATE_PASSWORD','Update Password','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'UPDATE_PASSWORD',30),('bddb6adb-5c0c-42fc-bb2c-8ea634cd46eb','delete_account','Delete Account','15e56e88-e77b-45e1-afa4-0d9a64309354',0,0,'delete_account',60),('c21cd0d6-a427-4d0d-ba8e-ce898ded2e0d','UPDATE_PROFILE','Update Profile','f65da957-0a1a-47d4-9781-0118b7c15e3d',1,0,'UPDATE_PROFILE',40),('c40f8021-5c5e-4847-a92a-002101e51447','CONFIGURE_TOTP','Configure OTP','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'CONFIGURE_TOTP',10),('c61a5641-c157-4099-b6f6-5b1ce8708a96','VERIFY_EMAIL','Verify Email','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'VERIFY_EMAIL',50),('c6beee2f-6b7a-4c63-9227-5682070f78dd','VERIFY_PROFILE','Verify Profile','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'VERIFY_PROFILE',90),('d4602fe7-1b4e-46a4-8283-9781753a7d4c','VERIFY_EMAIL','Verify Email','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'VERIFY_EMAIL',50),('d4bda52c-9d34-4d92-8b1a-d7e7d03f1f7c','webauthn-register-passwordless','Webauthn Register Passwordless','15e56e88-e77b-45e1-afa4-0d9a64309354',1,0,'webauthn-register-passwordless',80),('dcc1aec9-7e47-455b-b2e1-5bbd1cb97765','update_user_locale','Update User Locale','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'update_user_locale',1000),('e546454c-7513-431d-9b56-f242ccb0f06b','webauthn-register','Webauthn Register','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf',1,0,'webauthn-register',70);
/*!40000 ALTER TABLE `REQUIRED_ACTION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `RESOURCE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_5HRM2VLF9QL5FU022KQEPOVBR` (`RESOURCE_ID`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU022KQEPOVBR` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_ATTRIBUTE`
--

LOCK TABLES `RESOURCE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_POLICY` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`POLICY_ID`),
  KEY `IDX_RES_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRPOS53XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPP213XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_POLICY`
--

LOCK TABLES `RESOURCE_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SCOPE` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`SCOPE_ID`),
  KEY `IDX_RES_SCOPE_SCOPE` (`SCOPE_ID`),
  CONSTRAINT `FK_FRSRPOS13XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRPS213XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SCOPE`
--

LOCK TABLES `RESOURCE_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER` (
  `ID` varchar(36) NOT NULL,
  `ALLOW_RS_REMOTE_MGMT` tinyint NOT NULL DEFAULT '0',
  `POLICY_ENFORCE_MODE` tinyint DEFAULT NULL,
  `DECISION_STRATEGY` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER`
--

LOCK TABLES `RESOURCE_SERVER` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_PERM_TICKET`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_PERM_TICKET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_PERM_TICKET` (
  `ID` varchar(36) NOT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `REQUESTER` varchar(255) DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint NOT NULL,
  `GRANTED_TIMESTAMP` bigint DEFAULT NULL,
  `RESOURCE_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5PMT` (`OWNER`,`REQUESTER`,`RESOURCE_SERVER_ID`,`RESOURCE_ID`,`SCOPE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG82SSPMT` (`RESOURCE_SERVER_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG83SSPMT` (`RESOURCE_ID`),
  KEY `FK_FRSRHO213XCX4WNKOG84SSPMT` (`SCOPE_ID`),
  KEY `FK_FRSRPO2128CX4WNKOG82SSRFY` (`POLICY_ID`),
  KEY `IDX_PERM_TICKET_REQUESTER` (`REQUESTER`),
  KEY `IDX_PERM_TICKET_OWNER` (`OWNER`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSPMT` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG83SSPMT` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG84SSPMT` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`),
  CONSTRAINT `FK_FRSRPO2128CX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_PERM_TICKET`
--

LOCK TABLES `RESOURCE_SERVER_PERM_TICKET` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_PERM_TICKET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_POLICY`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_POLICY` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `DESCRIPTION` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `TYPE` varchar(255) NOT NULL,
  `DECISION_STRATEGY` tinyint DEFAULT NULL,
  `LOGIC` tinyint DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRPT700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SERV_POL_RES_SERV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRPO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_POLICY`
--

LOCK TABLES `RESOURCE_SERVER_POLICY` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_RESOURCE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_RESOURCE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_RESOURCE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `OWNER` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `OWNER_MANAGED_ACCESS` tinyint NOT NULL DEFAULT '0',
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSR6T700S9V50BU18WS5HA6` (`NAME`,`OWNER`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_RES_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_RESOURCE`
--

LOCK TABLES `RESOURCE_SERVER_RESOURCE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_RESOURCE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_SERVER_SCOPE`
--

DROP TABLE IF EXISTS `RESOURCE_SERVER_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_SERVER_SCOPE` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `ICON_URI` varchar(255) DEFAULT NULL,
  `RESOURCE_SERVER_ID` varchar(36) DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_FRSRST700S9V50BU18WS5HA6` (`NAME`,`RESOURCE_SERVER_ID`),
  KEY `IDX_RES_SRV_SCOPE_RES_SRV` (`RESOURCE_SERVER_ID`),
  CONSTRAINT `FK_FRSRSO213XCX4WNKOG82SSRFY` FOREIGN KEY (`RESOURCE_SERVER_ID`) REFERENCES `RESOURCE_SERVER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_SERVER_SCOPE`
--

LOCK TABLES `RESOURCE_SERVER_SCOPE` WRITE;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_SERVER_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RESOURCE_URIS`
--

DROP TABLE IF EXISTS `RESOURCE_URIS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RESOURCE_URIS` (
  `RESOURCE_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`RESOURCE_ID`,`VALUE`),
  CONSTRAINT `FK_RESOURCE_SERVER_URIS` FOREIGN KEY (`RESOURCE_ID`) REFERENCES `RESOURCE_SERVER_RESOURCE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESOURCE_URIS`
--

LOCK TABLES `RESOURCE_URIS` WRITE;
/*!40000 ALTER TABLE `RESOURCE_URIS` DISABLE KEYS */;
/*!40000 ALTER TABLE `RESOURCE_URIS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ROLE_ATTRIBUTE`
--

DROP TABLE IF EXISTS `ROLE_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ROLE_ATTRIBUTE` (
  `ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_ROLE_ATTRIBUTE` (`ROLE_ID`),
  CONSTRAINT `FK_ROLE_ATTRIBUTE_ID` FOREIGN KEY (`ROLE_ID`) REFERENCES `KEYCLOAK_ROLE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ROLE_ATTRIBUTE`
--

LOCK TABLES `ROLE_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `ROLE_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_MAPPING`
--

DROP TABLE IF EXISTS `SCOPE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SCOPE_MAPPING` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `ROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`ROLE_ID`),
  KEY `IDX_SCOPE_MAPPING_ROLE` (`ROLE_ID`),
  CONSTRAINT `FK_OUSE064PLMLR732LXJCN1Q5F1` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_MAPPING`
--

LOCK TABLES `SCOPE_MAPPING` WRITE;
/*!40000 ALTER TABLE `SCOPE_MAPPING` DISABLE KEYS */;
INSERT INTO `SCOPE_MAPPING` VALUES ('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','10a68de3-37a3-4dba-a7b1-93c46f301301'),('d994103a-c761-49e1-83cd-8dd421412620','23cc61cf-547e-404c-9cff-b995591fe5bc'),('d994103a-c761-49e1-83cd-8dd421412620','50ee3323-63e2-47cd-b06f-fc1b97b61cc1'),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','61f2ba25-88d0-4497-b52d-258fd324d3e1'),('a30d47d0-c3ae-4592-a804-aafcd3cbc81d','f4f8dcf0-61d8-48b2-982d-3190aa8b52bf'),('2fb2e693-63d5-46cf-a8cc-f1f36e1418d6','fba80ab2-e523-49e9-844b-6020172821fd');
/*!40000 ALTER TABLE `SCOPE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SCOPE_POLICY`
--

DROP TABLE IF EXISTS `SCOPE_POLICY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SCOPE_POLICY` (
  `SCOPE_ID` varchar(36) NOT NULL,
  `POLICY_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`SCOPE_ID`,`POLICY_ID`),
  KEY `IDX_SCOPE_POLICY_POLICY` (`POLICY_ID`),
  CONSTRAINT `FK_FRSRASP13XCX4WNKOG82SSRFY` FOREIGN KEY (`POLICY_ID`) REFERENCES `RESOURCE_SERVER_POLICY` (`ID`),
  CONSTRAINT `FK_FRSRPASS3XCX4WNKOG82SSRFY` FOREIGN KEY (`SCOPE_ID`) REFERENCES `RESOURCE_SERVER_SCOPE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCOPE_POLICY`
--

LOCK TABLES `SCOPE_POLICY` WRITE;
/*!40000 ALTER TABLE `SCOPE_POLICY` DISABLE KEYS */;
/*!40000 ALTER TABLE `SCOPE_POLICY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ATTRIBUTE`
--

DROP TABLE IF EXISTS `USER_ATTRIBUTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ATTRIBUTE` (
  `NAME` varchar(255) NOT NULL,
  `VALUE` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `ID` varchar(36) NOT NULL DEFAULT 'sybase-needs-something-here',
  `LONG_VALUE_HASH` binary(64) DEFAULT NULL,
  `LONG_VALUE_HASH_LOWER_CASE` binary(64) DEFAULT NULL,
  `LONG_VALUE` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  PRIMARY KEY (`ID`),
  KEY `IDX_USER_ATTRIBUTE` (`USER_ID`),
  KEY `IDX_USER_ATTRIBUTE_NAME` (`NAME`,`VALUE`),
  KEY `USER_ATTR_LONG_VALUES` (`LONG_VALUE_HASH`,`NAME`),
  KEY `USER_ATTR_LONG_VALUES_LOWER_CASE` (`LONG_VALUE_HASH_LOWER_CASE`,`NAME`),
  CONSTRAINT `FK_5HRM2VLF9QL5FU043KQEPOVBR` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ATTRIBUTE`
--

LOCK TABLES `USER_ATTRIBUTE` WRITE;
/*!40000 ALTER TABLE `USER_ATTRIBUTE` DISABLE KEYS */;
INSERT INTO `USER_ATTRIBUTE` VALUES ('gender','Male','600c7d3a-d660-451f-8fb9-edd45470b1d7','098d37c9-5c7f-4797-9a1a-620ae404f4e2',NULL,NULL,NULL),('picture','avatar_johndoe.png','600c7d3a-d660-451f-8fb9-edd45470b1d7','0d35978a-c1ef-4833-a0d1-0007adca9520',NULL,NULL,NULL),('country','Vietnam','b07a6427-f410-43cf-b0d8-8c20cbe2cc43','0dfe5b56-feb3-4981-bb59-6555fa68f799',NULL,NULL,NULL),('postalCode','12011','b07a6427-f410-43cf-b0d8-8c20cbe2cc43','2ebce498-1f07-486e-86b7-7384408f4e5c',NULL,NULL,NULL),('gender','Male','b07a6427-f410-43cf-b0d8-8c20cbe2cc43','386f5b7a-d8d8-4404-bde0-47b64c709b44',NULL,NULL,NULL),('gender','Male','2ae0321a-1c75-46d9-9cc5-1782aed402c1','55cc14ee-44eb-4fec-a3fb-79d44fb17f66',NULL,NULL,NULL),('picture','avatar_b07a6427-f410-43cf-b0d8-8c20cbe2cc43.jpg','b07a6427-f410-43cf-b0d8-8c20cbe2cc43','594ae5c2-c32e-4fe7-9b32-1887d7599411',NULL,NULL,NULL),('city','London','600c7d3a-d660-451f-8fb9-edd45470b1d7','5b6875be-8b30-4fed-a36e-161ecd458319',NULL,NULL,NULL),('postalCode','12345','600c7d3a-d660-451f-8fb9-edd45470b1d7','6046a980-b2a1-4be5-a73c-97ab5dac1d7a',NULL,NULL,NULL),('postalCode','160000','2ae0321a-1c75-46d9-9cc5-1782aed402c1','6464f4f2-5d96-4e34-83b2-ec203e2f0154',NULL,NULL,NULL),('phoneNumber','03219123838','b07a6427-f410-43cf-b0d8-8c20cbe2cc43','66d58936-fc2c-4c4c-b298-1b4b968f1685',NULL,NULL,NULL),('birthday','1990-01-01','600c7d3a-d660-451f-8fb9-edd45470b1d7','7561534f-35eb-408f-84b5-163404dc6ef2',NULL,NULL,NULL),('city','Hanoi','b07a6427-f410-43cf-b0d8-8c20cbe2cc43','79a13eaf-4e7c-472d-87c7-05b5abd85fe8',NULL,NULL,NULL),('country','Vietnam','600c7d3a-d660-451f-8fb9-edd45470b1d7','7a883fb1-42bb-490f-b4d0-b4b5e66b16c6',NULL,NULL,NULL),('city','Hưng Yên','2ae0321a-1c75-46d9-9cc5-1782aed402c1','7bf26e11-4391-4cd4-a758-0f953379a606',NULL,NULL,NULL),('phoneNumber','0123456789','600c7d3a-d660-451f-8fb9-edd45470b1d7','889e3564-f748-4c71-a61e-079623e8c192',NULL,NULL,NULL),('phoneNumber','0345221946','2ae0321a-1c75-46d9-9cc5-1782aed402c1','933137bd-132d-4671-81b3-b7137d0378fa',NULL,NULL,NULL),('birthday','2002-05-17','2ae0321a-1c75-46d9-9cc5-1782aed402c1','94b32a53-729e-4c98-ab8e-ae5516e91544',NULL,NULL,NULL),('country','Việt Nam','2ae0321a-1c75-46d9-9cc5-1782aed402c1','ced176e3-384d-4e5d-b960-08dbd781c8d7',NULL,NULL,NULL),('birthday','2002-09-09','b07a6427-f410-43cf-b0d8-8c20cbe2cc43','ceebce57-d31a-4aa8-bc82-1ce2e42153d9',NULL,NULL,NULL),('picture','https://iam.didan.id.vn/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Favatar.c20862b9.webp&w=750&q=80','2ae0321a-1c75-46d9-9cc5-1782aed402c1','fadbb088-5e67-432d-b909-0625588e8813',NULL,NULL,NULL);
/*!40000 ALTER TABLE `USER_ATTRIBUTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT`
--

DROP TABLE IF EXISTS `USER_CONSENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_CONSENT` (
  `ID` varchar(36) NOT NULL,
  `CLIENT_ID` varchar(255) DEFAULT NULL,
  `USER_ID` varchar(36) NOT NULL,
  `CREATED_DATE` bigint DEFAULT NULL,
  `LAST_UPDATED_DATE` bigint DEFAULT NULL,
  `CLIENT_STORAGE_PROVIDER` varchar(36) DEFAULT NULL,
  `EXTERNAL_CLIENT_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_LOCAL_CONSENT` (`CLIENT_ID`,`USER_ID`),
  UNIQUE KEY `UK_EXTERNAL_CONSENT` (`CLIENT_STORAGE_PROVIDER`,`EXTERNAL_CLIENT_ID`,`USER_ID`),
  KEY `IDX_USER_CONSENT` (`USER_ID`),
  CONSTRAINT `FK_GRNTCSNT_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT`
--

LOCK TABLES `USER_CONSENT` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_CONSENT_CLIENT_SCOPE`
--

DROP TABLE IF EXISTS `USER_CONSENT_CLIENT_SCOPE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_CONSENT_CLIENT_SCOPE` (
  `USER_CONSENT_ID` varchar(36) NOT NULL,
  `SCOPE_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`USER_CONSENT_ID`,`SCOPE_ID`),
  KEY `IDX_USCONSENT_CLSCOPE` (`USER_CONSENT_ID`),
  KEY `IDX_USCONSENT_SCOPE_ID` (`SCOPE_ID`),
  CONSTRAINT `FK_GRNTCSNT_CLSC_USC` FOREIGN KEY (`USER_CONSENT_ID`) REFERENCES `USER_CONSENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_CONSENT_CLIENT_SCOPE`
--

LOCK TABLES `USER_CONSENT_CLIENT_SCOPE` WRITE;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_CONSENT_CLIENT_SCOPE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ENTITY`
--

DROP TABLE IF EXISTS `USER_ENTITY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ENTITY` (
  `ID` varchar(36) NOT NULL,
  `EMAIL` varchar(255) DEFAULT NULL,
  `EMAIL_CONSTRAINT` varchar(255) DEFAULT NULL,
  `EMAIL_VERIFIED` tinyint NOT NULL DEFAULT '0',
  `ENABLED` tinyint NOT NULL DEFAULT '0',
  `FEDERATION_LINK` varchar(255) DEFAULT NULL,
  `FIRST_NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `LAST_NAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `CREATED_TIMESTAMP` bigint DEFAULT NULL,
  `SERVICE_ACCOUNT_CLIENT_LINK` varchar(255) DEFAULT NULL,
  `NOT_BEFORE` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UK_DYKN684SL8UP1CRFEI6ECKHD7` (`REALM_ID`,`EMAIL_CONSTRAINT`),
  UNIQUE KEY `UK_RU8TT6T700S9V50BU18WS5HA6` (`REALM_ID`,`USERNAME`),
  KEY `IDX_USER_EMAIL` (`EMAIL`),
  KEY `IDX_USER_SERVICE_ACCOUNT` (`REALM_ID`,`SERVICE_ACCOUNT_CLIENT_LINK`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ENTITY`
--

LOCK TABLES `USER_ENTITY` WRITE;
/*!40000 ALTER TABLE `USER_ENTITY` DISABLE KEYS */;
INSERT INTO `USER_ENTITY` VALUES ('2ae0321a-1c75-46d9-9cc5-1782aed402c1','messiprohy@gmail.com','messiprohy@gmail.com',1,1,NULL,'Nguyễn','Di Đan','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','didannguyen',1729096844254,NULL,0),('3092ccac-6a5c-4adf-ae2a-db29613ed31a',NULL,'804719d1-a275-43ce-9754-740788d2f1e5',0,1,NULL,NULL,NULL,'f65da957-0a1a-47d4-9781-0118b7c15e3d','didannguyen',1728833036089,NULL,0),('600c7d3a-d660-451f-8fb9-edd45470b1d7','kovor90550@lineacr.com','kovor90550@lineacr.com',1,1,NULL,'John','Doe','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','johndoe',1731346566216,NULL,0),('b07a6427-f410-43cf-b0d8-8c20cbe2cc43','test1@gmail.com','test1@gmail.com',1,1,NULL,'Test','Test','7a980d75-7b84-4cb7-b04e-b43a4dd3c8bf','test1',1728834071715,NULL,1728836817);
/*!40000 ALTER TABLE `USER_ENTITY` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_CONFIG` (
  `USER_FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_PROVIDER_ID`,`NAME`),
  CONSTRAINT `FK_T13HPU1J94R2EBPEKR39X5EU5` FOREIGN KEY (`USER_FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_CONFIG`
--

LOCK TABLES `USER_FEDERATION_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_MAPPER` (
  `ID` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `FEDERATION_PROVIDER_ID` varchar(36) NOT NULL,
  `FEDERATION_MAPPER_TYPE` varchar(255) NOT NULL,
  `REALM_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_MAP_FED_PRV` (`FEDERATION_PROVIDER_ID`),
  KEY `IDX_USR_FED_MAP_REALM` (`REALM_ID`),
  CONSTRAINT `FK_FEDMAPPERPM_FEDPRV` FOREIGN KEY (`FEDERATION_PROVIDER_ID`) REFERENCES `USER_FEDERATION_PROVIDER` (`ID`),
  CONSTRAINT `FK_FEDMAPPERPM_REALM` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER`
--

LOCK TABLES `USER_FEDERATION_MAPPER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_MAPPER_CONFIG`
--

DROP TABLE IF EXISTS `USER_FEDERATION_MAPPER_CONFIG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_MAPPER_CONFIG` (
  `USER_FEDERATION_MAPPER_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) NOT NULL,
  PRIMARY KEY (`USER_FEDERATION_MAPPER_ID`,`NAME`),
  CONSTRAINT `FK_FEDMAPPER_CFG` FOREIGN KEY (`USER_FEDERATION_MAPPER_ID`) REFERENCES `USER_FEDERATION_MAPPER` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_MAPPER_CONFIG`
--

LOCK TABLES `USER_FEDERATION_MAPPER_CONFIG` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_MAPPER_CONFIG` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_FEDERATION_PROVIDER`
--

DROP TABLE IF EXISTS `USER_FEDERATION_PROVIDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_FEDERATION_PROVIDER` (
  `ID` varchar(36) NOT NULL,
  `CHANGED_SYNC_PERIOD` int DEFAULT NULL,
  `DISPLAY_NAME` varchar(255) DEFAULT NULL,
  `FULL_SYNC_PERIOD` int DEFAULT NULL,
  `LAST_SYNC` int DEFAULT NULL,
  `PRIORITY` int DEFAULT NULL,
  `PROVIDER_NAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDX_USR_FED_PRV_REALM` (`REALM_ID`),
  CONSTRAINT `FK_1FJ32F6PTOLW2QY60CD8N01E8` FOREIGN KEY (`REALM_ID`) REFERENCES `REALM` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_FEDERATION_PROVIDER`
--

LOCK TABLES `USER_FEDERATION_PROVIDER` WRITE;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_FEDERATION_PROVIDER` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_GROUP_MEMBERSHIP`
--

DROP TABLE IF EXISTS `USER_GROUP_MEMBERSHIP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_GROUP_MEMBERSHIP` (
  `GROUP_ID` varchar(36) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`GROUP_ID`,`USER_ID`),
  KEY `IDX_USER_GROUP_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_USER_GROUP_USER` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_GROUP_MEMBERSHIP`
--

LOCK TABLES `USER_GROUP_MEMBERSHIP` WRITE;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_GROUP_MEMBERSHIP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_REQUIRED_ACTION`
--

DROP TABLE IF EXISTS `USER_REQUIRED_ACTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_REQUIRED_ACTION` (
  `USER_ID` varchar(36) NOT NULL,
  `REQUIRED_ACTION` varchar(255) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`REQUIRED_ACTION`,`USER_ID`),
  KEY `IDX_USER_REQACTIONS` (`USER_ID`),
  CONSTRAINT `FK_6QJ3W1JW9CVAFHE19BWSIUVMD` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_REQUIRED_ACTION`
--

LOCK TABLES `USER_REQUIRED_ACTION` WRITE;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_REQUIRED_ACTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_ROLE_MAPPING`
--

DROP TABLE IF EXISTS `USER_ROLE_MAPPING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_ROLE_MAPPING` (
  `ROLE_ID` varchar(255) NOT NULL,
  `USER_ID` varchar(36) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `IDX_USER_ROLE_MAPPING` (`USER_ID`),
  CONSTRAINT `FK_C4FQV34P1MBYLLOXANG7B1Q3L` FOREIGN KEY (`USER_ID`) REFERENCES `USER_ENTITY` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_ROLE_MAPPING`
--

LOCK TABLES `USER_ROLE_MAPPING` WRITE;
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` DISABLE KEYS */;
INSERT INTO `USER_ROLE_MAPPING` VALUES ('e077c769-f87c-419d-a7e3-5c1e1fe91168','2ae0321a-1c75-46d9-9cc5-1782aed402c1'),('efcea55c-be64-401d-a1d7-6bc3557250ec','2ae0321a-1c75-46d9-9cc5-1782aed402c1'),('f1280c1e-2251-4910-ae43-eadba9f9f379','2ae0321a-1c75-46d9-9cc5-1782aed402c1'),('fc199046-925d-4680-a317-34be8a5b0a9e','2ae0321a-1c75-46d9-9cc5-1782aed402c1'),('1383d857-16f6-4b23-a33c-4faf641f0d11','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('1fe4547f-02b7-4627-8fce-577578e107a0','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('2bede393-3463-4edb-8339-cfa293adfbec','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('2ef1b15e-bdb5-4bc1-bf64-882af80d2b9d','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('3ad05b7f-013f-4190-b345-7fa00cff2caf','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('3cf35d9a-ad2a-4274-95e3-607901f3debe','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('3f234307-1a91-49b5-bb56-77fc8fb39a94','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('5a98df6b-33b5-4190-a825-40c7780a1cdb','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('64df9e25-5d24-4027-baca-aebb78fde590','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('700825d6-4083-4276-8f10-8162318b2305','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('70c15f4f-78dc-43ca-950a-f07c219e077b','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('7b149774-efd3-477b-b9f5-4fa474ae319f','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('7b73b976-9f80-4b0d-b362-3fa7274f980f','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('82a090ea-efe4-4141-a859-f31a2c687997','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('888f0324-6c7f-4354-adf8-a89029384d9d','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('8d14bc18-5839-4940-8a48-ea12cae65d56','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('931e92ad-7859-4fcf-afc4-5edcfe9b2384','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('93f198f6-cf1d-432f-9d6e-25aaccadd875','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('97ccf601-9d0c-42c5-85b7-cc660c268b58','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('986b1529-6e82-47bb-b98e-2d0c1d1e2af8','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('98763f74-f973-4360-a387-83bc348b5514','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('a2f57d4a-97ca-4fe5-813a-36e942bbd785','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('aef6402f-979d-409e-9d08-21eec85c4435','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('b49341ad-3e39-4eb6-a238-6fddb4525557','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('b7e599fd-ccf2-4f75-b7ce-a1e08b7c3cb3','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('c137756b-cae9-462a-b02d-ba02e9b79228','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('d206f4f1-4605-4a70-bb6b-7a38cc7a38d9','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('d70f6e26-e9b5-424a-b7c5-76487bc11eaf','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('d751f761-0bd8-4eae-9487-9331afbfd6e4','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('dde77f95-83f6-4206-9262-e3e22044819a','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('e23ba581-fb61-426c-8a6e-578accb4b53e','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('e4ad8c8e-24f5-4d5f-8625-aec603709762','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('e4fecb29-e432-41a7-b3e4-4f9e3785fc61','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('eec3c8fc-2436-498a-ae9a-ba018c445250','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('f80a66f3-93b8-47bb-8546-0652eef90a46','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('f8ee14a9-1356-4e2a-9197-082b8725ba59','3092ccac-6a5c-4adf-ae2a-db29613ed31a'),('e077c769-f87c-419d-a7e3-5c1e1fe91168','600c7d3a-d660-451f-8fb9-edd45470b1d7'),('f1280c1e-2251-4910-ae43-eadba9f9f379','600c7d3a-d660-451f-8fb9-edd45470b1d7'),('e077c769-f87c-419d-a7e3-5c1e1fe91168','b07a6427-f410-43cf-b0d8-8c20cbe2cc43'),('f1280c1e-2251-4910-ae43-eadba9f9f379','b07a6427-f410-43cf-b0d8-8c20cbe2cc43');
/*!40000 ALTER TABLE `USER_ROLE_MAPPING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION`
--

DROP TABLE IF EXISTS `USER_SESSION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_SESSION` (
  `ID` varchar(36) NOT NULL,
  `AUTH_METHOD` varchar(255) DEFAULT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `LAST_SESSION_REFRESH` int DEFAULT NULL,
  `LOGIN_USERNAME` varchar(255) DEFAULT NULL,
  `REALM_ID` varchar(255) DEFAULT NULL,
  `REMEMBER_ME` tinyint NOT NULL DEFAULT '0',
  `STARTED` int DEFAULT NULL,
  `USER_ID` varchar(255) DEFAULT NULL,
  `USER_SESSION_STATE` int DEFAULT NULL,
  `BROKER_SESSION_ID` varchar(255) DEFAULT NULL,
  `BROKER_USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION`
--

LOCK TABLES `USER_SESSION` WRITE;
/*!40000 ALTER TABLE `USER_SESSION` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SESSION_NOTE`
--

DROP TABLE IF EXISTS `USER_SESSION_NOTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USER_SESSION_NOTE` (
  `USER_SESSION` varchar(36) NOT NULL,
  `NAME` varchar(255) NOT NULL,
  `VALUE` text,
  PRIMARY KEY (`USER_SESSION`,`NAME`),
  CONSTRAINT `FK5EDFB00FF51D3472` FOREIGN KEY (`USER_SESSION`) REFERENCES `USER_SESSION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SESSION_NOTE`
--

LOCK TABLES `USER_SESSION_NOTE` WRITE;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USER_SESSION_NOTE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERNAME_LOGIN_FAILURE`
--

DROP TABLE IF EXISTS `USERNAME_LOGIN_FAILURE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `USERNAME_LOGIN_FAILURE` (
  `REALM_ID` varchar(36) NOT NULL,
  `USERNAME` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `FAILED_LOGIN_NOT_BEFORE` int DEFAULT NULL,
  `LAST_FAILURE` bigint DEFAULT NULL,
  `LAST_IP_FAILURE` varchar(255) DEFAULT NULL,
  `NUM_FAILURES` int DEFAULT NULL,
  PRIMARY KEY (`REALM_ID`,`USERNAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERNAME_LOGIN_FAILURE`
--

LOCK TABLES `USERNAME_LOGIN_FAILURE` WRITE;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` DISABLE KEYS */;
/*!40000 ALTER TABLE `USERNAME_LOGIN_FAILURE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WEB_ORIGINS`
--

DROP TABLE IF EXISTS `WEB_ORIGINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `WEB_ORIGINS` (
  `CLIENT_ID` varchar(36) NOT NULL,
  `VALUE` varchar(255) NOT NULL,
  PRIMARY KEY (`CLIENT_ID`,`VALUE`),
  KEY `IDX_WEB_ORIG_CLIENT` (`CLIENT_ID`),
  CONSTRAINT `FK_LOJPHO213XCX4WNKOG82SSRFY` FOREIGN KEY (`CLIENT_ID`) REFERENCES `CLIENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WEB_ORIGINS`
--

LOCK TABLES `WEB_ORIGINS` WRITE;
/*!40000 ALTER TABLE `WEB_ORIGINS` DISABLE KEYS */;
INSERT INTO `WEB_ORIGINS` VALUES ('45eab072-6c16-4ce9-895e-b8b1567fbb1c','+'),('565a59c8-7ca2-47eb-b2a4-23ca31d10617','+'),('56e41688-ad77-45be-9ea5-5feeebdd496e','+'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','http://localhost:3000/*'),('5c9f576c-0650-4a12-b3d0-b4556649baf4','http://localhost:8072/*'),('a0b15bbe-0ab7-4f99-8f51-5f39d62de58f','*');
/*!40000 ALTER TABLE `WEB_ORIGINS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-13  3:10:31

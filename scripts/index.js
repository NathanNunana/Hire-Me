//@ts-check
import { createClient } from "@supabase/supabase-js";
import dotenv from "dotenv";
import axios from "axios";

const start = async () => {
  const http = axios.create({
    baseURL: "http://api.adzuna.com/v1/api/jobs/gb/",
    params: {
      "content-type": "application/json",
    },
  });
  const key = `app_id=21610e78&app_key=c0960f74b56436d129ef83a3c0a3810d&content-type=application/json`;

  dotenv.config({
    path: ".env",
  });

  const supabase = createClient(
    process.env.SUPABASE_URL ?? "",
    process.env.SUPABASE_ANON ?? ""
  );

  const saveJob = async (job) => {
    const { error } = await supabase.from("jobs").insert({
      location: job.location.display_name,
      area: job.location.area,
      company: job.company.display_name,
      created: job.created,
      min_salary: job.salary_min,
      max_salary: job.salary_max,
      category: job.category.label,
      category_tag: job.category.tag,
      title: job.title,
      description: job.description,
      contract_time: job.contract_time,
      contract_type: job.contract_type,
      job_id: Number.parseInt(job.id),
    });
    console.log(`SAVED -> ${job.title}`);
    if (error) {
      console.log(`ERROR INSERTING`);
      console.log(error);
    }
  };

  const _all = [];
  const no_pages = 50;
  const per_page = 50;
  for (let i = 1; i < no_pages + 1; i++) {
    console.log(`MAIN LOOP = ${i}`);
    const res = await http.get(
      `/search/${i}/?${key}&results_per_page=${per_page}&what=golang`
    );
    const results = res.data.results;
    console.log(`RETRIEVED PAGE === ${i} ${results.length} Items`);

    results.forEach((job) => {
      _all.push(
        new Promise(() => {
          saveJob(job);
        })
      );
    });
  }
  await Promise.all(_all);
};

start();

/*
- location: string
- area: [] string
- company: string
- created: string
- min_salary: number (salary_min)
- max_salary: number (salary_max)
- category: string
- category_tag: string
- title: string
- description: string
- contract_time: string
- job_id: string (id)
- contract_type: string?
*/
